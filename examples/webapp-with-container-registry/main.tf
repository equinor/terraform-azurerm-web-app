provider "azurerm" {
  features {}
}

locals {
  app_name         = "ops-webapp"
  environment_name = "example"
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "rg-${local.app_name}-${local.environment_name}"
  location = "northeurope"
}

module "acr" {
  source = "github.com/equinor/terraform-azurerm-acr?ref=f426cb96b17e7e26faab096fdde61e390c6329bc"

  app_name            = local.app_name
  environment_name    = local.environment_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  managed_identity_operators = [data.azurerm_client_config.current.object_id]
}

module "webapp" {
  source = "../.."

  app_name            = local.app_name
  environment_name    = local.environment_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  managed_identity_ids                          = [module.acr.managed_identity_id]
  container_registry_managed_identity_client_id = module.acr.managed_identity_client_id
}
