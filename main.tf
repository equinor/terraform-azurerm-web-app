locals {
  default_app_settings = {
    ACTIVE_DIRECTORY_AUTHENTICATION_SECRET = "@Microsoft.KeyVault(VaultName=${var.azuread_client_secret.vault_name};SecretName=${var.azuread_client_secret.secret_name})"
  }
}

resource "azurerm_service_plan" "this" {
  name                = coalesce(var.app_service_plan_name, "plan-${var.app_name}-${var.environment_name}")
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.app_service_plan_sku_name
}

resource "azurerm_linux_web_app" "this" {
  name                = coalesce(var.app_service_name, "app-${var.app_name}-${var.environment_name}")
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id

  https_only = true

  app_settings = merge(local.default_app_settings, var.app_settings)

  site_config {
    container_registry_use_managed_identity       = true
    container_registry_managed_identity_client_id = var.container_registry_managed_identity_client_id
  }

  auth_settings {
    enabled             = true
    token_store_enabled = true

    active_directory {
      client_id                  = var.azuread_client_id
      client_secret_setting_name = "ACTIVE_DIRECTORY_AUTHENTICATION_SECRET"
    }
  }

  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = var.managed_identity_ids
  }
}
