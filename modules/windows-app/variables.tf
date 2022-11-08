variable "name" {
  description = "The name of this Windows Web App."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
}

variable "service_plan_id" {
  description = "The ID of the service plan to create this Windows Web App for."
  type        = string
}

variable "auth_settings_enabled" {
  description = "Should the built-in authentication settings be enabled for this Windows Web App?"
  type        = bool
  default     = true
  nullable    = false
}

variable "aad_client_id" {
  description = "The client ID of the App Registration to use for Azure AD authentication."
  type        = string
}

variable "aad_client_secret_setting_name" {
  description = "The name of the app setting that should contain the client secret to use for Azure AD authentication."
  type        = string
  default     = "AAD_CLIENT_SECRET"
  nullable    = false
}

variable "key_vault_reference_identity_id" {
  description = "The ID of the Managed Identity that will be used to fetch app settings sourced from Key Vault."
  type        = string
  default     = null
}

variable "acr_managed_identity_client_id" {
  description = "The client ID of the Managed Identity that will be used to pull from the Container Registry."
  type        = string
  default     = null
}

variable "managed_identity_ids" {
  description = "The IDs of the Managed Identities to assign to this Windows Web App."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "custom_hostnames" {
  description = "A list of custom hostnames to bind to this Windows Web App."
  type        = list(string)
  default     = []
  nullable    = false
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