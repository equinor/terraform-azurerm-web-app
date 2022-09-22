module "service_plan" {
  source = "./modules/service-plan"

  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.sku_name

  tags = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = module.service_plan.id

  https_only = true

  # App settings should be configured during deployment
  app_settings = null

  tags = var.tags

  auth_settings {
    enabled             = var.auth_settings_enabled
    token_store_enabled = true

    active_directory {
      client_id                  = var.aad_client_id
      client_secret_setting_name = var.aad_client_secret_setting_name
    }
  }

  site_config {
    container_registry_use_managed_identity       = var.acr_managed_identity_client_id != null ? true : false
    container_registry_managed_identity_client_id = var.acr_managed_identity_client_id
  }

  identity {
    type         = length(var.managed_identity_ids) > 0 ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = var.managed_identity_ids
  }
}

# Add diagnostic setting to record audit logs for this Web App
resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = "audit-logs"
  target_resource_id         = azurerm_linux_web_app.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "AppServiceAuditLogs"
    enabled  = true

    retention_policy {
      days    = 0
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      days    = 0
      enabled = false
    }
  }
}

# Create a custom hostname binding for each custom hostname
resource "azurerm_app_service_custom_hostname_binding" "this" {
  for_each = toset(var.custom_hostnames)

  hostname            = each.value
  app_service_name    = azurerm_linux_web_app.this.name
  resource_group_name = var.resource_group_name
}

# Create a managed certificate for each custom hostname binding
resource "azurerm_app_service_managed_certificate" "this" {
  for_each = azurerm_app_service_custom_hostname_binding.this

  custom_hostname_binding_id = each.value.id
}

# Create a certificate binding for each managed certificate
resource "azurerm_app_service_certificate_binding" "this" {
  for_each = azurerm_app_service_managed_certificate.this

  hostname_binding_id = each.value.custom_hostname_binding_id
  certificate_id      = each.value.id
  ssl_state           = "SniEnabled"
}
