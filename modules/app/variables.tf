variable "name" {
  description = "The name of this Web App."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
}

variable "kind" {
  description = "The kind of Web App to create."
  type        = string
  default     = "Linux"

  validation {
    condition     = contains(["Linux", "Windows"], var.kind)
    error_message = "Kind must be \"Linux\" or \"Windows\"."
  }
}

variable "app_service_plan_id" {
  description = "The ID of the app service plan to create this Web App for."
  type        = string
}

variable "auth_settings_enabled" {
  description = "Should the built-in authentication settings be enabled for this Web App?"
  type        = bool
  default     = false
}

variable "auth_settings_active_directory" {
  description = "A list of authentication settings using the Active Directory provider to configure for this web app."

  type = list(object({
    client_id                  = string
    client_secret_setting_name = optional(string, "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET")
  }))

  default = []
}

variable "key_vault_reference_identity_id" {
  description = "The ID of the Managed Identity that will be used to fetch app settings sourced from Key Vault."
  type        = string
  default     = null
}

variable "websockets_enabled" {
  description = "Should web sockets be enabled for this Web App?"
  type        = bool
  default     = false
}

variable "container_registry_use_managed_identity" {
  description = "Should connections to Container Registry use Managed Identity?"
  type        = bool
  default     = false
}

variable "container_registry_managed_identity_client_id" {
  description = "The client ID of the Managed Identity that will be used to pull from the Container Registry."
  type        = string
  default     = null
}

variable "identity" {
  description = "The identity or identities to configure for this Web App."

  type = object({
    type         = optional(string, "SystemAssigned")
    identity_ids = optional(list(string), [])
  })

  default = null
}

variable "logs_detailed_error_messages" {
  description = "Should detailed error messages be enabled for logs?"
  type        = bool
  default     = false
}

variable "logs_failed_request_tracing" {
  description = "Should failed request tracing be enabled for logs?"
  type        = bool
  default     = false
}

variable "http_logs_file_system_retention_in_mb" {
  description = "The maximum size in megabytes that HTTP logs can use before being deleted from the file system."
  type        = number
  default     = 35
}

variable "http_logs_file_system_retention_in_days" {
  description = "The retention period in days before HTTP logs are deleted from the file system."
  type        = number
  default     = 0
}

variable "custom_hostnames" {
  description = "A list of custom hostnames to bind to this Web App."
  type        = list(string)
  default     = []
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
}

variable "log_analytics_destination_type" {
  description = "The type of log analytics destination to use for this Log Analytics Workspace."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
