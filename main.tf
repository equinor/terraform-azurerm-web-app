resource "azurerm_service_plan" "this" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.kind
  sku_name            = var.sku_name

  tags = var.tags
}

module "app" {
  source = "./modules/app"

  name                           = var.app_name
  resource_group_name            = var.resource_group_name
  location                       = var.location
  kind                           = var.kind
  app_service_plan_id            = azurerm_service_plan.this.id
  auth_settings_enabled          = var.auth_settings_enabled
  auth_settings_active_directory = var.auth_settings_active_directory
  websockets_enabled             = var.websockets_enabled
  acr_managed_identity_client_id = var.acr_managed_identity_client_id
  managed_identity_ids           = var.managed_identity_ids
  custom_hostnames               = var.custom_hostnames
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  tags                           = var.tags
}
