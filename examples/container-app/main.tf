provider "azurerm" {
  features {}
}

resource "random_id" "this" {
  byte_length = 8
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "this" {
  name     = "rg-${random_id.this.hex}"
  location = var.location
}

module "log_analytics" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.1.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

module "acr" {
  source = "github.com/equinor/terraform-azurerm-acr?ref=v2.0.0"

  application                = random_id.this.hex
  environment                = "test"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  managed_identity_operators = [data.azurerm_client_config.current.object_id]
}

module "web_app" {
  source = "../.."

  app_name                       = "app-${random_id.this.hex}"
  location                       = azurerm_resource_group.this.location
  resource_group_name            = azurerm_resource_group.this.name
  service_plan_name              = "plan-${random_id.this.hex}"
  aad_client_id                  = "fe94e238-69a9-4633-94d0-c7f56dea76e8"
  acr_managed_identity_client_id = module.acr.managed_identity_client_id
  managed_identity_ids           = [module.acr.managed_identity_id]
}
