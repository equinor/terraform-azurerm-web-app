provider "azurerm" {
  features {}
}

locals {
  application = random_id.this.hex
  environment = "test"
}

resource "random_id" "this" {
  byte_length = 8
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.application}-${local.environment}"
  location = var.location
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "log-${local.application}-${local.environment}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

module "vault" {
  source = "github.com/equinor/terraform-azurerm-vault?ref=v3.0.0"

  application = local.application
  environment = local.environment

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  client_secret_permissions = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]

  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}

resource "azurerm_key_vault_secret" "this" {
  name         = "ClientSecret"
  value        = "my-secret"
  key_vault_id = module.vault.key_vault_id
}

module "acr" {
  source = "github.com/equinor/terraform-azurerm-acr?ref=v2.0.0"

  application = local.application
  environment = local.environment

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  managed_identity_operators = [data.azurerm_client_config.current.object_id]
}

module "plan" {
  source = "../../modules/app-service-plan"

  application = local.application
  environment = local.environment

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

module "web_app" {
  source = "../.."

  application = local.application
  environment = local.environment

  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  service_plan_id = module.plan.app_service_plan_id

  azuread_client_id     = "fe94e238-69a9-4633-94d0-c7f56dea76e8"
  key_vault_name        = module.vault.key_vault_name
  key_vault_secret_name = azurerm_key_vault_secret.this.name

  managed_identity_client_id = module.acr.managed_identity_client_id
  managed_identity_id        = module.acr.managed_identity_id
}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id = module.vault.key_vault_id
  tenant_id    = module.web_app.app_service_identity_tenant_id
  object_id    = module.web_app.app_service_identity_principal_id

  secret_permissions = ["Get"]
}
