provider "azurerm" {
  features {
    resource_group {
      # Azure sometimes automatically creates a "default" app service plan that is not managed by Terraform,
      # preventing Terraform from destroying the resource group.
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
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.4.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

module "app_service" {
  source = "github.com/equinor/terraform-azurerm-app-service?ref=v1.0.0"

  plan_name           = "plan-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

module "web_app" {
  source = "../.."

  app_name              = "app-${random_id.this.hex}"
  resource_group_name   = azurerm_resource_group.this.name
  location              = azurerm_resource_group.this.location
  app_service_plan_id   = module.app_service.plan_id
  auth_settings_enabled = true

  diagnostic_settings = {
    "audit" = {
      log_analytics_workspace_id = module.log_analytics.workspace_id
    }
  }

  auth_settings_active_directory = [
    {
      client_id = "00000000-0000-0000-0000-000000000000"
    }
  ]

  # Store client secret as a slot-sticky app setting named "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET".
  # Use Key Vault references to managed the secret in Azure Key Vault.
}
