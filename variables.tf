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
  description = "The kind of Web App to create. Allowed values are \"Linux\" and \"Windows\"."
  type        = string
  default     = "Linux"

  validation {
    condition     = contains(["Linux", "Windows"], var.kind)
    error_message = "Kind must be \"Linux\" or \"Windows\"."
  }
}

variable "app_settings" {
  description = "A map of app settings to be configured for this Web App."
  type        = map(string)
  default     = {}
  nullable    = false

  validation {
    condition     = length(setintersection(["DOCKER_REGISTRY_SERVER_URL", "DOCKER_REGISTRY_SERVER_USERNAME", "DOCKER_REGISTRY_SERVER_PASSWORD"], keys(var.app_settings))) == 0
    error_message = "Docker settings must be configured using \"application_stack\"."
  }

  validation {
    condition     = length(setintersection(["WEBSITE_HTTPLOGGING_ENABLED", "WEBSITE_HTTPLOGGING_RETENTION_DAYS", "WEBSITE_HTTPLOGGING_CONTAINER_URL"], keys(var.app_settings))) == 0
    error_message = "HTTP logging settings must be configured using \"http_logs_file_system_retention_in_mb\" and \"http_logs_file_system_retention_in_days\"."
  }

  validation {
    condition     = length(setintersection(["BUILD", "BUILD_NUMBER", "BUILD_ID"], keys(var.app_settings))) == 0
    error_message = "Build settings must be configured outside of Terraform, commonly in a CI/CD pipeline."
  }
}

variable "application_stack" {
  description = "An object of application stack settings for this Web App. Note that application stack settings are often configured outside of Terraform (for example when deploying code), so configuring application stack settings in Terraform may cause conflicts."

  type = object({
    docker_image_name        = string
    docker_registry_url      = string
    docker_registry_username = optional(string)
    docker_registry_password = optional(string)
    current_stack            = optional(string)
  })

  default = null
}

variable "active_directory_tenant_auth_endpoint" {
  description = "The endpoint of the Microsoft Entra tenant to use for authentication."
  type        = string
  default     = null
}

variable "active_directory_client_id" {
  description = "The client ID of the Microsoft Entra app registration to use for authentication."
  type        = string
  default     = null
}

variable "active_directory_client_secret_setting_name" {
  description = "The name of the app setting to get the client secret of the Microsoft Entra app registration from."
  type        = string
  default     = "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET"
}

variable "active_directory_login_parameters" {
  description = "A map of key-value pairs to send to the authorization endpoint when a user logs in."
  type        = map(string)
  default     = {}
}

variable "client_affinity_enabled" {
  description = "Should client affinity be enabled for this Web App?"
  type        = bool
  default     = false
}

variable "key_vault_reference_identity_id" {
  description = "The ID of the managed identity that will be used to fetch app settings sourced from Key Vault."
  type        = string
  default     = null
}

variable "virtual_network_subnet_id" {
  description = "The ID of a virtual network subnet to integrate this Web App with."
  type        = string
  default     = null
}

variable "vnet_route_all_enabled" {
  description = "Should all outbound traffic have NAT Gateways, network security groups and user-defined routes applied?"
  type        = bool
  default     = false
}

variable "websockets_enabled" {
  description = "Should web sockets be enabled for this Web App?"
  type        = bool
  default     = false
}

variable "container_registry_use_managed_identity" {
  description = "Should connections to Container Registry use managed identity?"
  type        = bool
  default     = null
}

variable "container_registry_managed_identity_client_id" {
  description = "The client ID of the managed identity that will be used to pull from the Container Registry."
  type        = string
  default     = null
}

variable "always_on" {
  description = "Should this Web App be loaded even when there is no traffic?"
  type        = bool
  default     = true
}

variable "ftps_state" {
  description = "The state of FTP/FTPS service. Possible values include \"AllAllowed\", \"FtpsOnly\", and \"Disabled\"."
  type        = string
  default     = "Disabled"
}

variable "ip_restrictions" {
  description = "A list of IP restrictions to be configured for this Web App."

  type = list(object({
    action      = optional(string, "Allow")
    ip_address  = optional(string)
    name        = string
    priority    = number
    service_tag = optional(string)

    headers = optional(object({
      x_forwarded_for   = optional(list(string))
      x_forwarded_host  = optional(list(string))
      x_azure_fdid      = optional(list(string))
      x_fd_health_probe = optional(list(string))
    }))
  }))

  default = []
}

variable "ip_restriction_default_action" {
  description = "The default action for traffic that does not match any IP restriction rule."
  type        = string
  default     = "Allow"
}

variable "scm_ip_restriction_default_action" {
  description = "The default action for traffic to the Source Control Manager (SCM) that does not match any IP restriction rule."
  type        = string
  default     = "Allow"
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

variable "diagnostic_setting_enabled_metric_categories" {
  description = "A list of metric categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = []
}

variable "diagnostic_setting_name" {
  description = "The name of the diagnostic setting."
  type        = string
  default     = "audit-logs"
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
