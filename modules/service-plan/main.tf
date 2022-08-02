locals {
  suffix       = "${var.application}-${var.environment}"
  suffix_alnum = join("", regexall("[a-z0-9]", lower(local.suffix)))
  tags         = merge({ application = var.application, environment = var.environment }, var.tags)
}

resource "azurerm_service_plan" "this" {
  name                = "plan-${var.application}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.sku_name
}
