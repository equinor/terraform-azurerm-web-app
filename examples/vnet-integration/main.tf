provider "azurerm" {
  features {}
}

resource "random_id" "this" {
  byte_length = 8
}

module "log_analytics" {
  source  = "equinor/log-analytics/azurerm"
  version = "2.2.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "network" {
  source  = "equinor/network/azurerm"
  version = "3.1.0"

  vnet_name           = "vnet-${random_id.this.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_spaces      = ["10.0.0.0/16"]

  subnets = {
    "app" = {
      name             = "snet-app-${random_id.this.hex}"
      address_prefixes = ["10.0.0.0/26"]

      delegations = [{
        service_name    = "Microsoft.Web/serverFarms"
        service_actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }]
    }
  }
}

module "app_service" {
  source  = "equinor/app-service/azurerm"
  version = "2.1.0"

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
  kind                       = module.app_service.os_type
  log_analytics_workspace_id = module.log_analytics.workspace_id
  virtual_network_subnet_id  = module.network.subnet_ids["app"]
}
