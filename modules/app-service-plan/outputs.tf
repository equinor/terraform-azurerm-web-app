output "app_service_plan_name" {
  description = "The name of this App Service plan."
  value       = azurerm_service_plan.this.name
}

output "app_service_plan_id" {
  description = "The ID of this App Service plan."
  value       = azurerm_service_plan.this.id
}
