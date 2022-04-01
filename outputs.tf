output "app_service_plan_name" {
  description = "Name of the created app service plan"
  value       = azurerm_service_plan.this.name
}

output "app_service_plan_id" {
  description = "ID of the created app service plan"
  value       = azurerm_service_plan.this.id
}

output "app_service_name" {
  description = "Name of the created app service"
  value       = azurerm_linux_web_app.this.name
}

output "app_service_id" {
  description = "ID of the created app service"
  value       = azurerm_linux_web_app.this.id
}

output "app_service_managed_identity" {
  description = "Principal ID and tenant ID of the created app service"
  value = {
    principal_id = azurerm_linux_web_app.this.identity[0].principal_id
    tenant_id    = azurerm_linux_web_app.this.identity[0].tenant_id
  }
}
