variable "app_name" {
  description = "Application name, used to generate resource names"
  type        = string
}

variable "environment_name" {
  description = "Environment name, used to generate resource names"
  type        = string
}

variable "resource_group_name" {
  description = "Name of resource group to create resources in"
  type        = string
}

variable "location" {
  description = "Location to create resources in"
  type        = string
}

variable "managed_identity_ids" {
  description = "IDs of managed identities to be assigned to the web app"
  type        = list(string)
}

variable "container_registry_managed_identity_client_id" {
  description = "Client ID of managed identity that will be used to pull image from container registry"
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of app service plan to create, generated if not set"
  type        = string
  default     = null
}

variable "app_service_plan_sku_name" {
  description = "SKU name of app service plan to create"
  type        = string
  default     = "B1"
}

variable "app_service_name" {
  description = "Name of app service to create, generated if not set"
  type        = string
  default     = null
}
