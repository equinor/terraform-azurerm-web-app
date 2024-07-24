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

  active_directory_client_id = "00000000-0000-0000-0000-000000000000"
  # Store client secret as a slot-sticky app setting named "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET".
  # Use Key Vault references to managed the secret in Azure Key Vault.
}
