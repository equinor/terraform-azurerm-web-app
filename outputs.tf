output "app_service_id" {
  description = "The ID of the App Service."
  value       = azurerm_linux_web_app.this.id
}

output "app_service_name" {
  description = "The name of the App Service."
  value       = azurerm_linux_web_app.this.name
}

output "app_service_identity_principal_id" {
  description = "The principal ID of the App Service Identity."
  value       = azurerm_linux_web_app.this.identity[0].principal_id
}

output "app_service_identity_tenant_id" {
  description = "The tenant ID of the App Service Identity."
  value       = azurerm_linux_web_app.this.identity[0].tenant_id
}
