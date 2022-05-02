locals {
  tags = merge({ application = var.application, environment = var.environment }, var.tags)
}

resource "azurerm_service_plan" "this" {
  name                = coalesce(var.app_service_plan_name, "plan-${var.application}-${var.environment}")
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.app_service_plan_sku_name

  tags = local.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = coalesce(var.app_service_name, "app-${var.application}-${var.environment}")
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id

  https_only = true

  app_settings = merge({ ACTIVE_DIRECTORY_AUTHENTICATION_SECRET = "@Microsoft.KeyVault(VaultName=${var.key_vault_name};SecretName=${var.key_vault_secret_name})" }, var.app_service_settings)

  tags = local.tags

  auth_settings {
    enabled             = true
    token_store_enabled = true

    active_directory {
      client_id                  = var.azuread_client_id
      client_secret_setting_name = "ACTIVE_DIRECTORY_AUTHENTICATION_SECRET"
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
