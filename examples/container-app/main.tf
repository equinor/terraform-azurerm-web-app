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

module "acr" {
  source = "github.com/equinor/terraform-azurerm-acr?ref=v5.0.0"

  registry_name              = "cr${random_id.this.hex}"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  log_analytics_workspace_id = module.log_analytics.workspace_id
}

resource "azurerm_user_assigned_identity" "this" {
  name                = "id-${random_id.this.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = module.acr.registry_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
}

module "app_service" {
  source = "github.com/equinor/terraform-azurerm-app-service?ref=v1.0.0"

  plan_name           = "plan-${random_id.this.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "web_app" {
  source = "../.."

  app_name                                      = "app-${random_id.this.hex}"
  resource_group_name                           = var.resource_group_name
  location                                      = var.location
  app_service_plan_id                           = module.app_service.plan_id
  log_analytics_workspace_id                    = module.log_analytics.workspace_id
  container_registry_use_managed_identity       = true
  container_registry_managed_identity_client_id = azurerm_user_assigned_identity.this.client_id
  identity_ids                                  = [azurerm_user_assigned_identity.this.id]
}
