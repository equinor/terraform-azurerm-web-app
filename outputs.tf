output "app_id" {
  description = "The ID of this Web App."
  value       = azurerm_linux_web_app.this.id
}

output "app_name" {
  description = "The name of this Web App."
  value       = azurerm_linux_web_app.this.name
}

output "aad_client_secret_setting_name" {
  description = "The name of the app setting that contains the client secret of the App Registration to use for Azure AD authentication."
  value       = azurerm_linux_web_app.this.auth_settings[0].active_directory[0].client_secret_setting_name
}

output "identity_principal_id" {
  description = "The principal ID of the system-assigned identity of this Web App."
  value       = azurerm_linux_web_app.this.identity[0].principal_id
}

output "identity_tenant_id" {
  description = "The tenant ID of the system-assigned identity of this Web App."
  value       = azurerm_linux_web_app.this.identity[0].tenant_id
}
