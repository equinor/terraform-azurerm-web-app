provider "azurerm" {
  features {}
}

resource "random_id" "this" {
  byte_length = 8
}

module "log_analytics" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.4.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "network" {
  source = "github.com/equinor/terraform-azurerm-network?ref=v1.9.0"

  vnet_name           = "vnet-${random_id.this.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_spaces      = ["10.0.0.0/16"]

  subnets = {
    "app" = {
      name             = "snet-app-${random_id.this.hex}"
      address_prefixes = ["10.0.0.0/26"]

      delegation = [{
        service_delegation_name    = "Microsoft.Web/serverFarms"
        service_delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }]
    }
  }
}

module "app_service" {
  source = "github.com/equinor/terraform-azurerm-app-service?ref=v1.0.0"

  plan_name           = "plan-${random_id.this.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "web_app" {
  source = "../.."

  app_name                   = "app-${random_id.this.hex}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_plan_id        = module.app_service.plan_id
  log_analytics_workspace_id = module.log_analytics.workspace_id
  virtual_network_subnet_id  = module.network.subnet_ids["app"]
}
