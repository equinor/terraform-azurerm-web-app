output "app_service_plan_id" {
  description = "The ID of the App Service Plan."
  value       = azurerm_service_plan.this.id
}

output "app_service_plan_name" {
  description = "The name of the App Service Plan."
  value       = azurerm_service_plan.this.name
}

output "app_service_id" {
  description = "The ID of the App Service."
  value       = azurerm_linux_web_app.this.id
}

output "app_service_name" {
  description = "The name of the App Service."
  value       = azurerm_linux_web_app.this.name
}

output "app_service_identity_principal_id" {
  description = "The Principal ID associated with the System Assigned Identity of the App Service."
  value       = azurerm_linux_web_app.this.identity[0].principal_id
}

output "app_service_identity_tenant_id" {
  description = "The Tenant ID associated with the System Assigned Identity of the App Service."
  value       = azurerm_linux_web_app.this.identity[0].tenant_id
}
