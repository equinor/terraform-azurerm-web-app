variable "application" {
  description = "The application to create the resources for."
  type        = string
}

variable "environment" {
  description = "The environment to create the resources for."
  type        = string
}

variable "location" {
  description = "The supported Azure location where the resources exist."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "service_plan_id" {
  description = "The ID of the App Service Plan that this App Service will be created in."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "app_service_name" {
  description = "A custom name for the App Service."
  type        = string
  default     = null
}

variable "ip_restriction_allow" {
  description = "The action to allow or deny ip restrictions."
  type        = bool
  default     = false
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

variable "managed_identity_client_id" {
  description = "The client ID of the Managed Identity that will be used to pull from the Container Registry."
  type        = string
}

variable "managed_identity_id" {
  description = "The ID of the Managed Identity that will be used to pull from the Container Registry."
  type        = string
}

variable "app_service_hostnames" {
  description = "A list of custom hostnames to use for the App Service."
  type        = list(string)
  default     = []
}
