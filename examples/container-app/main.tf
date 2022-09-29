# Set feature flag within the `features` block when configuring the provider
# to enable Terraform to delete resource groups still containing resources. 
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
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

  service_plan_name   = "plan-${random_id.this.hex}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  apps = {
    "api" = {
      name                           = "app-${random_id.this.hex}-api"
      aad_client_id                  = "8487f986-ba7b-47df-bbd8-b657a6d737e5"
      acr_managed_identity_client_id = module.acr.managed_identity_client_id
      managed_identity_ids           = [module.acr.managed_identity_id]
    }

    "web" = {
      name                           = "app-${random_id.this.hex}-web"
      aad_client_id                  = "8487f986-ba7b-47df-bbd8-b657a6d737e5"
      acr_managed_identity_client_id = module.acr.managed_identity_client_id
      managed_identity_ids           = [module.acr.managed_identity_id]
    }
  }
}
