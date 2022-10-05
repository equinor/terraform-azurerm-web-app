variable "name" {
  description = "The name of this Linux Web App."
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
  description = "The ID of the service plan to create this Linux Web App for."
  type        = string
}

variable "auth_settings_enabled" {
  description = "Should authentication be enabled for this Linux Web App?"
  type        = bool
  default     = true
}

variable "aad_client_id" {
  description = "The client ID of the App Registration to use for Azure AD authentication."
  type        = string
  default     = null
}

variable "aad_client_secret_setting_name" {
  description = "The name of the app setting where the client secret of the App Registration to use for Azure AD authentication must be stored."
  type        = string
  default     = "AAD_CLIENT_SECRET"
}

variable "acr_managed_identity_client_id" {
  description = "The client ID of the Managed Identity that will be used to pull from the Container Registry."
  type        = string
  default     = null
}

variable "managed_identity_ids" {
  description = "The IDs of the Managed Identities to assign to this Linux Web App."
  type        = list(string)
  default     = []
}

variable "custom_hostnames" {
  description = "A list of custom hostnames to bind to this Linux Web App."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
