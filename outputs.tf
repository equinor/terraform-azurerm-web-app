output "app_id" {
  description = "The ID of this Web App."
  value       = local.web_app.id
}

output "app_name" {
  description = "The name of this Web App."
  value       = local.web_app.name
}

output "identity_principal_id" {
  description = "The principal ID of the system-assigned identity of this Web App. This value will be null if no identity is assigned."
  value       = try(local.web_app.identity[0].principal_id, null)
}

output "identity_tenant_id" {
  description = "The tenant ID of the system-assigned identity of this Web App. This value will be null if no identity is assigned."
  value       = try(local.web_app.identity[0].tenant_id, null)
}

output "default_hostname" {
  description = "The default hostname of this Web App"
  value       = local.web_app.default_hostname
}

output "custom_domain_verification_id" {
  description = "The identifier used by App Service to perform domain ownership verification via DNS TXT record."
  value       = local.web_app.custom_domain_verification_id
}
