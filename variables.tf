variable "app_name" {
  description = "The name of this Web App."
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

variable "service_plan_name" {
  description = "The name of this Web App service plan."
  type        = string
}

variable "sku_name" {
  description = "The SKU name for this service plan."
  type        = string
  default     = "B1"
}

variable "auth_settings_enabled" {
  description = "Should authentication be enabled for this Web App?"
  type        = bool
  default     = true
}

variable "aad_client_id" {
  description = "The client ID of the App Registration to use for Azure AD authentication."
  type        = string
}

variable "aad_client_secret_setting_name" {
  description = "The name of the app setting that contains the client secret of the App Registration to use for Azure AD authentication."
  type        = string
  default     = "AAD_CLIENT_SECRET"
}

variable "acr_managed_identity_client_id" {
  description = "The client ID of the Managed Identity that will be used to pull from the Container Registry."
  type        = string
  default     = null
}

variable "managed_identity_ids" {
  description = "The IDs of the Managed Identities to assign to this Web App."
  type        = list(string)
  default     = []
}

variable "custom_hostnames" {
  description = "A list of custom hostnames to bind to this Web App."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
