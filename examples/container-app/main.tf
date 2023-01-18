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
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.2.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

module "acr" {
  source = "github.com/equinor/terraform-azurerm-acr?ref=v4.3.0"

  registry_name              = "cr${random_id.this.hex}"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  log_analytics_workspace_id = module.log_analytics.workspace_id
}

resource "azurerm_user_assigned_identity" "this" {
  name                = "id-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = module.acr.registry_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}

module "web_app" {
  source = "../.."

  app_name                                      = "app-${random_id.this.hex}"
  app_service_plan_name                         = "plan-${random_id.this.hex}"
  location                                      = azurerm_resource_group.this.location
  resource_group_name                           = azurerm_resource_group.this.name
  log_analytics_workspace_id                    = module.log_analytics.workspace_id
  container_registry_use_managed_identity       = true
  container_registry_managed_identity_client_id = azurerm_user_assigned_identity.this.client_id

  identity = {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }
}
