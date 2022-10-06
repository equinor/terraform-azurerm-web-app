variable "service_plan_name" {
  description = "The name of this Web App service plan."
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

variable "os_type" {
  description = "The OS type for the apps to be hosted on this Web App service plan."
  type        = string
  default     = "Linux"
}

variable "sku_name" {
  description = "The SKU name for this service plan."
  type        = string
  default     = "B1"
}

variable "apps" {
  description = "A map of identifier => Linux/Windows Web App objects"
  type = map(object({
    name                           = string
    auth_settings_enabled          = optional(bool)
    aad_client_id                  = string
    aad_client_secret_setting_name = optional(string)
    acr_managed_identity_client_id = optional(string)
    managed_identity_ids           = optional(list(string))
    custom_hostnames               = optional(list(string))
  }))
  default = {}
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
