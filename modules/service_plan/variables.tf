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

variable "os_type" {
  description = "The OS Type of this Service Plan."
  type        = string
  default     = "Linux"
}

variable "sku_name" {
  description = "The SKU name of this Service Plan."
  type        = string
  default     = "B1"
}

variable "tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
