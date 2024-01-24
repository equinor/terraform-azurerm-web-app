variable "app_name" {
  description = "The name of this Web App."
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

variable "app_service_plan_id" {
  description = "The ID of the App Service plan to host this Web App on."
  type        = string
}

variable "kind" {
  description = "The kind of Web App to create."
  type        = string
  default     = "Linux"

  validation {
    condition     = contains(["Linux", "Windows"], var.kind)
    error_message = "Kind must be \"Linux\" or \"Windows\"."
  }
}

variable "active_directory_client_id" {
  description = "The client ID of the Azure AD app registration to use for authentication."
  type        = string
  default     = null
}

variable "active_directory_client_secret_setting_name" {
  description = "The name of the app setting to get the Azure AD app registration client secret from."
  type        = string
  default     = "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET"
}

variable "client_affinity_enabled" {
  description = "Should Client Affinity be enabled?"
  type        = bool
  default     = false
}

variable "key_vault_reference_identity_id" {
  description = "The ID of the Managed Identity that will be used to fetch app settings sourced from Key Vault."
  type        = string
  default     = null
}

variable "virtual_network_subnet_id" {
  description = "The ID of the virtual network subnet to configure for this Web App."
  type        = string
  default     = null
}

variable "vnet_route_all_enabled" {
  description = "Should all outbound traffic have NAT Gateways, Network Security Groups and User Defined Routes applied?"
  type        = bool
  default     = false
}

variable "websockets_enabled" {
  description = "Should web sockets be enabled for this Web App?"
  type        = bool
  default     = false
}

variable "container_registry_use_managed_identity" {
  description = "Should connections to Container Registry use Managed Identity?"
  type        = bool
  default     = null
}

variable "container_registry_managed_identity_client_id" {
  description = "The client ID of the Managed Identity that will be used to pull from the Container Registry."
  type        = string
  default     = null
}

variable "ftps_state" {
  description = "The State of FTP / FTPS service. Possible values include \"AllAllowed\", \"FtpsOnly\", and \"Disabled\"."
  type        = string
  default     = "Disabled"
}

variable "ip_restrictions" {
  description = "A list of IP restrictions to be configured for this Web App."

  type = list(object({
    action     = optional(string, "Allow")
    ip_address = string
    name       = string
    priority   = number

    headers = optional(object({
      x_forwarded_for   = optional(list(string))
      x_forwarded_host  = optional(list(string))
      x_azure_fdid      = optional(list(string))
      x_fd_health_probe = optional(list(string))
    }))
  }))

  default = []
}

variable "application_logs_file_system_level" {
  description = "The level of application logs to be enabled. Possible values include \"Verbose\", \"Information\", \"Warning\" and \"Error\"."
  type        = string
  default     = "Error"
}

variable "logs_detailed_error_messages" {
  description = "Should detailed error messages be enabled for logs?"
  type        = bool
  default     = false
}

variable "logs_failed_request_tracing" {
  description = "Should failed request tracing be enabled for logs?"
  type        = bool
  default     = false
}

variable "http_logs_file_system_retention_in_mb" {
  description = "The maximum size in megabytes that HTTP logs can use before being deleted from the file system."
  type        = number
  default     = 35
}

variable "http_logs_file_system_retention_in_days" {
  description = "The retention period in days before HTTP logs are deleted from the file system."
  type        = number
  default     = 0
}

variable "custom_hostname_bindings" {
  description = "A list of custom hostnames to bind to this Web App."

  type = map(object({
    hostname  = string
    ssl_state = optional(string, "SniEnabled")
  }))

  default = {}
}

variable "system_assigned_identity_enabled" {
  description = "Should the system-assigned identity be enabled for this Web App?"
  type        = bool
  default     = false
}

variable "identity_ids" {
  description = "A list of IDs of managed identities to be assigned to this Web App."
  type        = list(string)
  default     = []
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)

  default = [
    "AppServiceHTTPLogs",
    "AppServiceConsoleLogs",
    "AppServiceAppLogs",
    "AppServiceAuditLogs",
    "AppServiceIPSecAuditLogs",
    "AppServicePlatformLogs"
  ]
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
