variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "location" {
  description = "The name of the location to create the resources in."
  type        = string
}

variable "logs_analytics_enable" {
  description = "Should logs_analytics be enable for the web app?"
  default = true
  type = bool
  
}