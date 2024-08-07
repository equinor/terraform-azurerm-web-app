locals {
  is_windows = var.kind == "Windows"

  https_only = true

  container_registry_use_managed_identity = coalesce(var.container_registry_use_managed_identity, var.container_registry_managed_identity_client_id != null)

  # The following values are set automatically by Azure.
  # Set explicitly to prevent Terraform from detecting them as "changes made outside of Terraform".
  auth_settings_enabled                            = true
  auth_settings_require_authentication             = true
  auth_settings_default_provider                   = "azureactivedirectory"
  auth_settings_excluded_paths                     = []
  auth_settings_token_store_enabled                = true
  auth_settings_allowed_external_redirect_urls     = []
  active_directory_tenant_auth_endpoint            = coalesce(var.active_directory_tenant_auth_endpoint, "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}/v2.0")
  active_directory_allowed_audiences               = var.active_directory_client_id != null ? ["api://${var.active_directory_client_id}"] : []
  active_directory_allowed_groups                  = []
  active_directory_allowed_applications            = []
  active_directory_allowed_identities              = []
  active_directory_jwt_allowed_client_applications = []
  active_directory_jwt_allowed_groups              = []

  # Auto assign Key Vault reference identity
  identity_ids = concat(compact([var.key_vault_reference_identity_id]), var.identity_ids)

  # If system_assigned_identity_enabled is true, value is "SystemAssigned".
  # If identity_ids is non-empty, value is "UserAssigned".
  # If system_assigned_identity_enabled is true and identity_ids is non-empty, value is "SystemAssigned, UserAssigned".
  identity_type = join(", ", compact([var.system_assigned_identity_enabled ? "SystemAssigned" : "", length(local.identity_ids) > 0 ? "UserAssigned" : ""]))

  web_app = local.is_windows ? azurerm_windows_web_app.this[0] : azurerm_linux_web_app.this[0]

  diagnostic_setting_metric_categories = ["AllMetrics"]
}

data "azurerm_client_config" "current" {}

resource "azurerm_linux_web_app" "this" {
  count = local.is_windows ? 0 : 1

  name                            = var.app_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  service_plan_id                 = var.app_service_plan_id
  app_settings                    = var.app_settings
  https_only                      = local.https_only
  client_affinity_enabled         = var.client_affinity_enabled
  key_vault_reference_identity_id = var.key_vault_reference_identity_id
  public_network_access_enabled   = true
  virtual_network_subnet_id       = var.virtual_network_subnet_id

  tags = var.tags

  dynamic "connection_string" {
    for_each = var.connection_strings

    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  dynamic "auth_settings_v2" {
    for_each = var.active_directory_client_id == null ? [] : [1]

    content {
      auth_enabled           = local.auth_settings_enabled
      require_authentication = local.auth_settings_require_authentication
      default_provider       = local.auth_settings_default_provider
      excluded_paths         = local.auth_settings_excluded_paths

      login {
        token_store_enabled            = local.auth_settings_token_store_enabled
        allowed_external_redirect_urls = local.auth_settings_allowed_external_redirect_urls
      }

      active_directory_v2 {
        client_id                       = var.active_directory_client_id
        client_secret_setting_name      = var.active_directory_client_secret_setting_name
        tenant_auth_endpoint            = local.active_directory_tenant_auth_endpoint
        allowed_audiences               = local.active_directory_allowed_audiences
        allowed_groups                  = local.active_directory_allowed_groups
        allowed_applications            = local.active_directory_allowed_applications
        allowed_identities              = local.active_directory_allowed_identities
        jwt_allowed_client_applications = local.active_directory_jwt_allowed_client_applications
        jwt_allowed_groups              = local.active_directory_jwt_allowed_groups
        login_parameters                = var.active_directory_login_parameters
      }
    }
  }

  site_config {
    vnet_route_all_enabled                        = var.vnet_route_all_enabled
    websockets_enabled                            = var.websockets_enabled
    container_registry_use_managed_identity       = local.container_registry_use_managed_identity
    container_registry_managed_identity_client_id = var.container_registry_managed_identity_client_id
    always_on                                     = var.always_on
    ftps_state                                    = var.ftps_state
    ip_restriction_default_action                 = var.ip_restriction_default_action
    scm_ip_restriction_default_action             = var.scm_ip_restriction_default_action

    dynamic "ip_restriction" {
      for_each = var.ip_restrictions

      content {
        action      = ip_restriction.value.action
        headers     = ip_restriction.value.headers != null ? [ip_restriction.value.headers] : []
        ip_address  = ip_restriction.value.ip_address
        name        = ip_restriction.value.name
        priority    = ip_restriction.value.priority
        service_tag = ip_restriction.value.service_tag
      }
    }

    dynamic "application_stack" {
      for_each = var.application_stack == null ? toset([]) : toset([var.application_stack])

      content {
        docker_image_name        = application_stack.value.docker_image_name
        docker_registry_url      = application_stack.value.docker_registry_url
        docker_registry_username = application_stack.value.docker_registry_username
        docker_registry_password = application_stack.value.docker_registry_password
      }
    }
  }

  dynamic "identity" {
    for_each = local.identity_type != "" ? [1] : []

    content {
      type         = local.identity_type
      identity_ids = local.identity_ids
    }
  }

  logs {
    application_logs {
      file_system_level = var.application_logs_file_system_level
    }

    detailed_error_messages = var.logs_detailed_error_messages
    failed_request_tracing  = var.logs_failed_request_tracing

    http_logs {
      file_system {
        retention_in_mb   = var.http_logs_file_system_retention_in_mb
        retention_in_days = var.http_logs_file_system_retention_in_days
      }
    }
  }

  lifecycle {
    ignore_changes = [
      # This setting turns itself off after 12 hours.
      # Ignore changes to prevent cycle of turning on/off...
      logs[0].application_logs,

      # Ignore changes to common build settings.
      # These are usually configured in CI/CD pipelines.
      app_settings["BUILD"],
      app_settings["BUILD_NUMBER"],
      app_settings["BUILD_ID"]
    ]
  }
}

resource "azurerm_windows_web_app" "this" {
  count = local.is_windows ? 1 : 0

  name                            = var.app_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  service_plan_id                 = var.app_service_plan_id
  app_settings                    = var.app_settings
  https_only                      = local.https_only
  client_affinity_enabled         = var.client_affinity_enabled
  key_vault_reference_identity_id = var.key_vault_reference_identity_id
  public_network_access_enabled   = true
  virtual_network_subnet_id       = var.virtual_network_subnet_id

  tags = var.tags

  dynamic "connection_string" {
    for_each = var.connection_strings

    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  dynamic "auth_settings_v2" {
    for_each = var.active_directory_client_id == null ? [] : [1]

    content {
      auth_enabled           = local.auth_settings_enabled
      require_authentication = local.auth_settings_require_authentication
      default_provider       = local.auth_settings_default_provider
      excluded_paths         = local.auth_settings_excluded_paths

      login {
        token_store_enabled            = local.auth_settings_token_store_enabled
        allowed_external_redirect_urls = local.auth_settings_allowed_external_redirect_urls
      }

      active_directory_v2 {
        client_id                       = var.active_directory_client_id
        client_secret_setting_name      = var.active_directory_client_secret_setting_name
        tenant_auth_endpoint            = local.active_directory_tenant_auth_endpoint
        allowed_audiences               = local.active_directory_allowed_audiences
        allowed_groups                  = local.active_directory_allowed_groups
        allowed_applications            = local.active_directory_allowed_applications
        allowed_identities              = local.active_directory_allowed_identities
        jwt_allowed_client_applications = local.active_directory_jwt_allowed_client_applications
        jwt_allowed_groups              = local.active_directory_jwt_allowed_groups
        login_parameters                = var.active_directory_login_parameters
      }
    }
  }

  site_config {
    vnet_route_all_enabled                        = var.vnet_route_all_enabled
    websockets_enabled                            = var.websockets_enabled
    container_registry_use_managed_identity       = local.container_registry_use_managed_identity
    container_registry_managed_identity_client_id = var.container_registry_managed_identity_client_id
    always_on                                     = var.always_on
    ftps_state                                    = var.ftps_state
    ip_restriction_default_action                 = var.ip_restriction_default_action
    scm_ip_restriction_default_action             = var.scm_ip_restriction_default_action

    dynamic "ip_restriction" {
      for_each = var.ip_restrictions

      content {
        action      = ip_restriction.value.action
        headers     = ip_restriction.value.headers != null ? [ip_restriction.value.headers] : []
        ip_address  = ip_restriction.value.ip_address
        name        = ip_restriction.value.name
        priority    = ip_restriction.value.priority
        service_tag = ip_restriction.value.service_tag
      }
    }

    dynamic "application_stack" {
      for_each = var.application_stack == null ? toset([]) : toset([var.application_stack])

      content {
        docker_image_name        = application_stack.value.docker_image_name
        docker_registry_url      = application_stack.value.docker_registry_url
        docker_registry_username = application_stack.value.docker_registry_username
        docker_registry_password = application_stack.value.docker_registry_password
        current_stack            = application_stack.value.current_stack
      }
    }
  }

  dynamic "identity" {
    for_each = local.identity_type != "" ? [1] : []

    content {
      type         = local.identity_type
      identity_ids = local.identity_ids
    }
  }

  logs {
    application_logs {
      file_system_level = var.application_logs_file_system_level
    }

    detailed_error_messages = var.logs_detailed_error_messages
    failed_request_tracing  = var.logs_failed_request_tracing

    http_logs {
      file_system {
        retention_in_mb   = var.http_logs_file_system_retention_in_mb
        retention_in_days = var.http_logs_file_system_retention_in_days
      }
    }
  }

  lifecycle {
    ignore_changes = [
      # This setting turns itself off after 12 hours.
      # Ignore changes to prevent cycle of turning on/off...
      logs[0].application_logs,

      # Ignore changes to common build settings.
      # These are usually configured in CI/CD pipelines.
      app_settings["BUILD"],
      app_settings["BUILD_NUMBER"],
      app_settings["BUILD_ID"]
    ]
  }
}

check "build_settings_check" {
  assert {
    condition     = length(setintersection(["BUILD", "BUILD_NUMBER", "BUILD_ID"], keys(var.app_settings))) == 0
    error_message = "App settings \"BUILD\", \"BUILD_NUMBER\" and \"BUILD_ID\" should be configured outside of Terraform, commonly in a CI/CD pipeline. Any changes made to these app settings will be ignored."
  }
}

resource "azurerm_app_service_custom_hostname_binding" "this" {
  for_each = var.custom_hostname_bindings

  hostname            = each.value["hostname"]
  app_service_name    = local.web_app.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_app_service_managed_certificate" "this" {
  for_each = var.custom_hostname_bindings

  custom_hostname_binding_id = azurerm_app_service_custom_hostname_binding.this[each.key].id
}

resource "azurerm_app_service_certificate_binding" "this" {
  for_each = var.custom_hostname_bindings

  hostname_binding_id = azurerm_app_service_custom_hostname_binding.this[each.key].id
  certificate_id      = azurerm_app_service_managed_certificate.this[each.key].id
  ssl_state           = each.value["ssl_state"]
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = var.diagnostic_setting_name
  target_resource_id         = local.web_app.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # Ref: https://registry.terraform.io/providers/hashicorp/azurerm/3.65.0/docs/resources/monitor_diagnostic_setting#log_analytics_destination_type
  log_analytics_destination_type = null

  dynamic "enabled_log" {
    for_each = toset(var.diagnostic_setting_enabled_log_categories)

    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = toset(concat(local.diagnostic_setting_metric_categories, var.diagnostic_setting_enabled_metric_categories))

    content {
      # Azure expects explicit configuration of both enabled and disabled metric categories.
      category = metric.value
      enabled  = contains(var.diagnostic_setting_enabled_metric_categories, metric.value)
    }
  }
}
