resource "azurerm_service_plan" "this" {
  name                = coalesce(var.app_service_plan_name, "plan-${var.app_name}-${var.environment_name}")
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.app_service_plan_sku_name
}

resource "azurerm_linux_web_app" "this" {
  name                = coalesce(var.app_service_name, "app-${var.app_name}-${var.environment_name}")
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id

  https_only = true

  site_config {
    container_registry_use_managed_identity       = true
    container_registry_managed_identity_client_id = var.container_registry_managed_identity_client_id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = var.managed_identity_ids
  }
}
