locals {
  service_plan_name = substr(regex("^[a-zA-Z0-9-]+$", lower("plan-${var.application}-${var.environment}")), 0, 40)
  tags              = merge({ application = var.application, environment = var.environment }, var.tags)
}

resource "azurerm_service_plan" "this" {
  name                = coalesce(var.service_plan_name, local.service_plan_name)
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.sku_name
}
