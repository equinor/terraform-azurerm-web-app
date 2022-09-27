output "service_plan_id" {
  description = "The ID of this Web App service plan."
  value       = module.service_plan.id
}

output "service_plan_name" {
  description = "The name of this Web App service plan."
  value       = module.service_plan.name
}

output "app_ids" {
  description = "A mapping of Web App IDs for this service plan."
  value = {
    for k, v in module.linux_app : k => v.id
  }
}

output "app_names" {
  description = "A mapping of Web App names for this service plan."
  value = {
    for k, v in module.linux_app : k => v.name
  }
}

output "aad_client_secret_setting_names" {
  description = "A mapping of the app setting name where the Azure AD client secret must be stored for each Web App."
  value = {
    for k, v in module.linux_app : k => v.aad_client_secret_setting_name
  }
}

output "identity_principal_ids" {
  description = "A mapping of system-assigned identity IDs of the created Web Apps."
  value = {
    for k, v in module.linux_app : k => v.identity_principal_id
  }
}
