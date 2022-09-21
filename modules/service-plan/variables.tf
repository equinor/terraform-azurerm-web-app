variable "name" {
  description = "The name of this service plan."
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

variable "sku_name" {
  description = "The SKU name for this service plan."
  type        = string
  default     = "B1"
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
