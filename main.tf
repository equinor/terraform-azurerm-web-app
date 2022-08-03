locals {
  tags = merge({ application = var.application, environment = var.environment }, var.tags)
}

resource "azurerm_linux_web_app" "this" {
  name                = coalesce(var.app_service_name, "app-${var.application}-${var.environment}")
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id

  https_only = true

  # App settings should be configured during deployment
  app_settings = null

  tags = local.tags

  auth_settings {
    enabled             = true
    token_store_enabled = true

    active_directory {
      client_id                  = var.aad_client_id
      client_secret_setting_name = var.aad_client_secret_setting_name
    }
  }

  site_config {
    container_registry_use_managed_identity       = true
    container_registry_managed_identity_client_id = var.managed_identity_client_id
  }

  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [var.managed_identity_id]
  }
}

# Create a custom hostname binding for each custom hostname
resource "azurerm_app_service_custom_hostname_binding" "this" {
  for_each = toset(var.app_service_hostnames)

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
