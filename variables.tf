variable "application" {
  description = "The application to create the resources for."
  type        = string
}

variable "environment" {
  description = "The environment to create the resources for."
  type        = string
}

variable "app_service_plan_name" {
  description = "A custom name for the App Service Plan."
  type        = string
  default     = null
}

variable "location" {
  description = "Specifies the supported Azure location where the resources exist."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "app_service_plan_sku_name" {
  description = "The SKU name for the App Service Plan."
  type        = string
  default     = "B1"
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

variable "app_settings" {
  description = "A mapping of settings for the App Service."
  type        = map(string)
  default     = {}
}

variable "azuread_client_id" {
  description = "The ID of the Client to use to authenticate with Azure Active Directory."
  type        = string
}

variable "azuread_client_vault_name" {
  description = "The name of the Key Vault where the Client Secret is stored."
  type        = string
}

variable "azuread_client_secret_name" {
  description = "The name of the Key Vault Secret containing the Client Secret."
  type        = string
  default     = "ClientSecret"
}

variable "acr_identity_client_id" {
  description = "The Client ID of the User Assigned Identity to use for connections to the Azure Container Registry."
  type        = string
}

variable "acr_identity_id" {
  description = "The ID of the User Assigned Identity to use for connections to the Azure Container Registry."
  type        = string
}

variable "custom_hostnames" {
  description = "A list of custom hostnames to use for the App Service."
  type        = list(string)
  default     = []
}
