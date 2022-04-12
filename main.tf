locals {
  app_settings = {
    ACTIVE_DIRECTORY_AUTHENTICATION_SECRET = "@Microsoft.KeyVault(VaultName=${var.azuread_client_secret.vault_name};SecretName=${var.azuread_client_secret.secret_name})"
  }
}

resource "azurerm_service_plan" "this" {
  name                = coalesce(var.app_service_plan_name, "plan-${var.application}-${var.environment}")
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.app_service_plan_sku_name
}

resource "azurerm_linux_web_app" "this" {
  name                = coalesce(var.app_service_name, "app-${var.application}-${var.environment}")
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id

  https_only = true

  app_settings = merge(local.app_settings, var.app_settings)

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
    container_registry_managed_identity_client_id = var.acr_identity_client_id
  }

  identity {
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [var.acr_identity_id]
  }
}
