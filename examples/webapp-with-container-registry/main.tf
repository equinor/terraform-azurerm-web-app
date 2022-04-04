provider "azurerm" {
  features {}
}

locals {
  app_name         = "ops-webapp"
  environment_name = "example"
}

data "azurerm_client_config" "current" {}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "rg-${local.app_name}-${local.environment_name}"
  location = "northeurope"
}

# Create a log analytics workspace
resource "azurerm_log_analytics_workspace" "example" {
  name                = "log-${local.app_name}-${local.environment_name}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Free"
}

# Create a key vault
module "vault" {
  source = "github.com/equinor/terraform-azurerm-vault?ref=3f7e3a44d1c366266c17561970924c60eb29058e"

  app_name                   = local.app_name
  environment_name           = local.environment_name
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id

  client_permissions = {
    certificates = []
    keys         = []
    secrets      = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
  }
}

# Create a key vault secret containing the client secret to be used for Azure AD authentication
resource "azurerm_key_vault_secret" "example" {
  name         = "ClientSecret"
  value        = "super-secret-value"
  key_vault_id = module.vault.key_vault_id
}

# Create a container registry
module "acr" {
  source = "github.com/equinor/terraform-azurerm-acr?ref=f426cb96b17e7e26faab096fdde61e390c6329bc"

  app_name            = local.app_name
  environment_name    = local.environment_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  managed_identity_operators = [data.azurerm_client_config.current.object_id]
}

# Create the web app
module "webapp" {
  source = "../.."

  app_name            = local.app_name
  environment_name    = local.environment_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Assign identity with access to container registry to pull image from
  managed_identity_ids                          = [module.acr.managed_identity_id]
  container_registry_managed_identity_client_id = module.acr.managed_identity_client_id

  # Configure Azure AD authentication
  azuread_client_id = "fe94e238-69a9-4633-94d0-c7f56dea76e8"
  azuread_client_secret = {
    vault_name  = module.vault.key_vault_name
    secret_name = azurerm_key_vault_secret.example.name
  }
}

# Give web app access to key vault secret containing client secret
resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id = module.vault.key_vault_id
  tenant_id    = module.webapp.app_service_managed_identity.tenant_id
  object_id    = module.webapp.app_service_managed_identity.principal_id

  secret_permissions = ["Get"]
}
