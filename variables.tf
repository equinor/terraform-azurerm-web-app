variable "application" {
  description = "The application to create the resources for."
  type        = string
}

variable "environment" {
  description = "The environment to create the resources for."
  type        = string
}

variable "app_service_plan_name" {
  description = "Specifies the name of the App Service Plan."
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
  description = "The SKU name of the App Service Plan."
  type        = string
  default     = "B1"
}

variable "app_service_name" {
  description = "Specifies the name of the App Service."
  type        = string
  default     = null
}

variable "app_settings" {
  description = "A map of key-value pairs of App Settings."
  type        = map(string)
  default     = {}
}

variable "azuread_client_id" {
  description = "The ID of the Client to use to authenticate with Azure Active Directory."
  type        = string
}

variable "azuread_client_secret" {
  description = "The secret for the Client to use to authenticate with Azure Active Directory."
  type = object({
    key_vault_name        = string
    key_vault_secret_name = string
  })
}

variable "acr_identity_client_id" {
  description = "The Client ID of the User Assigned Identity to use for connections to the Azure Container Registry."
  type        = string
}

variable "acr_identity_id" {
  description = "The ID of the User Assigned Identity to use for connections to the Azure Container Registry."
  type        = string
}
