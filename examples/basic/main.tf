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

module "acr" {
  source = "github.com/equinor/terraform-azurerm-acr?ref=v2.0.0"

  application                = local.application
  environment                = local.environment
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  managed_identity_operators = [data.azurerm_client_config.current.object_id]
}

module "app_service_plan" {
  source = "../../modules/service-plan"

  application         = local.application
  environment         = local.environment
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

module "web_app" {
  source = "../.."

  application                = local.application
  environment                = local.environment
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  service_plan_id            = module.app_service_plan.service_plan_id
  aad_client_id              = "fe94e238-69a9-4633-94d0-c7f56dea76e8"
  managed_identity_client_id = module.acr.managed_identity_client_id
  managed_identity_id        = module.acr.managed_identity_id
}
