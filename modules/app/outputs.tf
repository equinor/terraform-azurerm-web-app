output "id" {
  description = "The ID of this Web App."
  value       = local.web_app.id
}

output "name" {
  description = "The name of this Web App."
  value       = local.web_app.name
}

output "aad_client_secret_setting_name" {
  description = "The name of the app setting that should contain the client secret to use for Azure AD authentication."
  value       = local.web_app.auth_settings[0].active_directory[0].client_secret_setting_name
}

output "identity_principal_id" {
  description = "The principal ID of the system-assigned identity of this Web App."
  value       = local.web_app.identity[0].principal_id
}

output "identity_tenant_id" {
  description = "The tenant ID of the system-assigned identity of this Web App."
  value       = local.web_app.identity[0].tenant_id
}
