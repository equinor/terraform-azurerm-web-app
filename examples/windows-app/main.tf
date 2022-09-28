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
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.1.1"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

module "web_app" {
  source = "../.."

  service_plan_name   = "plan-${random_id.this.hex}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Windows"

  apps = {
    "api" = {
      name          = "app-${random_id.this.hex}-api"
      aad_client_id = "1817f53f-93a7-475b-8a7f-94f0d3f94713"
    }

    "web" = {
      name          = "app-${random_id.this.hex}-web"
      aad_client_id = "1817f53f-93a7-475b-8a7f-94f0d3f94713"
    }
  }
}
