locals {
  service_plan_name = substr(regex("^[a-zA-Z0-9-]+$", lower("plan-${var.application}-${var.environment}")), 0, 40)
}

resource "azurerm_service_plan" "this" {
  name                = local.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name

  tags = merge(
    {
      application = var.application
      environment = var.environment
    },
    var.tags
  )
}
