output "app_name" {
  value = "app-${local.name_suffix}"
}

output "resource_group_name" {
  value = "rg-${local.name_suffix}"
}

output "location" {
  value = "northeurope"
}

output "app_service_plan_id" {
  value = local.app_service_plan_id
}

output "log_analytics_workspace_id" {
  value = "/subscriptions/${random_uuid.subscription_id.result}/resourceGroups/${local.resource_group_name}/providers/Microsoft.OperationalInsights/workspaces/log-${local.name_suffix}"
}
