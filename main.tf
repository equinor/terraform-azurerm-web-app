module "service_plan" {
  source = "./modules/service-plan"

  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name

  tags = var.tags
}

module "app" {
  for_each = var.apps

  source = "./modules/app"

  name                           = each.value.name
  resource_group_name            = var.resource_group_name
  location                       = var.location
  kind                           = var.os_type
  service_plan_id                = module.service_plan.id
  auth_settings_enabled          = each.value.auth_settings_enabled
  aad_client_id                  = each.value.aad_client_id
  aad_client_secret_setting_name = each.value.aad_client_secret_setting_name
  websockets_enabled             = each.value.websockets_enabled
  acr_managed_identity_client_id = each.value.acr_managed_identity_client_id
  managed_identity_ids           = each.value.managed_identity_ids
  custom_hostnames               = each.value.custom_hostnames
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  tags                           = var.tags
}
