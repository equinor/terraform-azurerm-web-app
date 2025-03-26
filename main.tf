data "azurerm_client_config" "current" {}

resource "azurerm_linux_web_app" "this" {
  count = local.is_windows ? 0 : 1

  name                            = var.app_name
  client_certificate_enabled      = var.client_certificate_enabled
  client_certificate_mode         = var.client_certificate_mode
  location                        = var.location
  resource_group_name             = var.resource_group_name
  service_plan_id                 = var.app_service_plan_id
  app_settings                    = null # Manage using standalone resource instead.
  https_only                      = local.https_only
  client_affinity_enabled         = var.client_affinity_enabled
  key_vault_reference_identity_id = var.key_vault_reference_identity_id
  public_network_access_enabled   = var.public_network_access_enabled
  virtual_network_subnet_id       = var.virtual_network_subnet_id
  zip_deploy_file                 = var.zip_deploy_file

  ftp_publish_basic_authentication_enabled       = var.ftp_publish_basic_authentication_enabled
  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled

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
    http2_enabled                                 = var.http2_enabled
    use_32_bit_worker                             = var.use_32_bit_worker
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

    dynamic "cors" {
      for_each = length(var.cors_allowed_origins) > 0 || var.cors_support_credentials ? [0] : []

      content {
        allowed_origins     = var.cors_allowed_origins
        support_credentials = var.cors_support_credentials
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

  dynamic "storage_account" {
    for_each = var.storage_accounts

    content {
      access_key   = "@AppSettingRef(${storage_account.value.access_key_setting_name})"
      account_name = storage_account.value.account_name
      mount_path   = storage_account.value.mount_path
      name         = storage_account.value.name
      share_name   = storage_account.value.share_name
      type         = storage_account.value.type
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

      # Ignore changes to app settings.
      # Manage using standalone resource instead.
      app_settings,

      # Ignore changes to hidden tags that are managed by Azure.
      tags["hidden-link: /app-insights-conn-string"],
      tags["hidden-link: /app-insights-instrumentation-key"],
      tags["hidden-link: /app-insights-resource-id"]
    ]
  }

  dynamic "sticky_settings" {
    for_each = length(var.sticky_settings_app_setting_names) > 0 || length(var.sticky_settings_connection_string_names) > 0 ? [0] : []

    content {
      app_setting_names       = length(var.sticky_settings_app_setting_names) > 0 ? var.sticky_settings_app_setting_names : null
      connection_string_names = length(var.sticky_settings_connection_string_names) > 0 ? var.sticky_settings_connection_string_names : null
    }
  }
}

resource "azurerm_windows_web_app" "this" {
  count = local.is_windows ? 1 : 0

  name                            = var.app_name
  client_certificate_enabled      = var.client_certificate_enabled
  client_certificate_mode         = var.client_certificate_mode
  location                        = var.location
  resource_group_name             = var.resource_group_name
  service_plan_id                 = var.app_service_plan_id
  app_settings                    = null # Manage using standalone resource instead.
  https_only                      = local.https_only
  client_affinity_enabled         = var.client_affinity_enabled
  key_vault_reference_identity_id = var.key_vault_reference_identity_id
  public_network_access_enabled   = var.public_network_access_enabled
  virtual_network_subnet_id       = var.virtual_network_subnet_id
  zip_deploy_file                 = var.zip_deploy_file

  ftp_publish_basic_authentication_enabled       = var.ftp_publish_basic_authentication_enabled
  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled

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
    http2_enabled                                 = var.http2_enabled
    use_32_bit_worker                             = var.use_32_bit_worker
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

    dynamic "virtual_application" {
      for_each = var.virtual_applications

      content {
        virtual_path  = virtual_application.value.virtual_path
        physical_path = virtual_application.value.physical_path
        preload       = virtual_application.value.preload

        dynamic "virtual_directory" {
          for_each = virtual_application.value.virtual_directories

          content {
            physical_path = virtual_directory.value.physical_path
            virtual_path  = virtual_directory.value.virtual_path
          }
        }
      }
    }

    dynamic "cors" {
      for_each = length(var.cors_allowed_origins) > 0 || var.cors_support_credentials ? [0] : []

      content {
        allowed_origins     = var.cors_allowed_origins
        support_credentials = var.cors_support_credentials
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

  dynamic "storage_account" {
    for_each = var.storage_accounts

    content {
      access_key   = "@AppSettingRef(${storage_account.value.access_key_setting_name})"
      account_name = storage_account.value.account_name
      mount_path   = storage_account.value.mount_path
      name         = storage_account.value.name
      share_name   = storage_account.value.share_name
      type         = storage_account.value.type
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

      # Ignore changes to app settings.
      # Manage using standalone resource instead.
      app_settings,

      # Ignore changes to hidden tags that are managed by Azure.
      tags["hidden-link: /app-insights-conn-string"],
      tags["hidden-link: /app-insights-instrumentation-key"],
      tags["hidden-link: /app-insights-resource-id"]
    ]
  }

  dynamic "sticky_settings" {
    for_each = length(var.sticky_settings_app_setting_names) > 0 || length(var.sticky_settings_connection_string_names) > 0 ? [0] : []

    content {
      app_setting_names       = length(var.sticky_settings_app_setting_names) > 0 ? var.sticky_settings_app_setting_names : null
      connection_string_names = length(var.sticky_settings_connection_string_names) > 0 ? var.sticky_settings_connection_string_names : null
    }
  }
}

# Manage app settings using the AzAPI provider instead of AzureRM.
# This enables the possibility of managing app settings either in Terraform or outside Terraform.
# Ref: https://learn.microsoft.com/en-us/azure/templates/microsoft.web/2022-09-01/sites/config-appsettings?pivots=deployment-language-terraform
#
# An issue has been created for a standalone "app_settings" resource to be implemented in the AzureRM provider.
# Ref: https://github.com/hashicorp/terraform-provider-azurerm/issues/28497
resource "azapi_update_resource" "app_settings" {
  type      = "Microsoft.Web/sites/config@2022-09-01"
  name      = "appsettings"
  parent_id = local.web_app.id

  body = {
    # Apply app settings managed in Terraform on top of app settings managed outside of Terraform.
    # Ensures that app settings managed outside of Terraform are not lost.
    properties = merge(local.web_app.app_settings, var.app_settings)
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
