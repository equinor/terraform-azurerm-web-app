output "name" {
  description = "The name of this service plan."
  value       = azurerm_service_plan.this.name
}

output "id" {
  description = "The ID of this service plan."
  value       = azurerm_service_plan.this.id
}
