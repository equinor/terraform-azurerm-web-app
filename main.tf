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

  name                                          = var.app_name
  resource_group_name                           = var.resource_group_name
  location                                      = var.location
  kind                                          = var.kind
  app_service_plan_id                           = azurerm_service_plan.this.id
  auth_settings_enabled                         = var.auth_settings_enabled
  auth_settings_active_directory                = var.auth_settings_active_directory
  websockets_enabled                            = var.websockets_enabled
  container_registry_use_managed_identity       = var.container_registry_use_managed_identity
  container_registry_managed_identity_client_id = var.container_registry_managed_identity_client_id
  identity                                      = var.identity
  logs_detailed_error_messages                  = var.logs_detailed_error_messages
  logs_failed_request_tracing                   = var.logs_failed_request_tracing
  http_logs_file_system_retention_in_mb         = var.http_logs_file_system_retention_in_mb
  http_logs_file_system_retention_in_days       = var.http_logs_file_system_retention_in_days
  custom_hostnames                              = var.custom_hostnames
  log_analytics_workspace_id                    = var.log_analytics_workspace_id
  log_analytics_destination_type                = var.log_analytics_destination_type
  tags                                          = var.tags
}
