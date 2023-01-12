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

variable "service_plan_id" {
  description = "The ID of the service plan to create this Web App for."
  type        = string
}

variable "auth_settings_enabled" {
  description = "Should the built-in authentication settings be enabled for this Web App?"
  type        = bool
  default     = true
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

variable "container_registry_managed_identity_client_id" {
  description = "The client ID of the Managed Identity that will be used to pull from the Container Registry."
  type        = string
  default     = null
}

variable "identity_ids" {
  description = "The IDs of the Managed Identities to assign to this Web App."
  type        = list(string)
  default     = []
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

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
