# Azure Web App Terraform module

[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![Equinor Terraform Baseline](https://img.shields.io/badge/Equinor%20Terraform%20Baseline-1.0.0-blueviolet)](https://github.com/equinor/terraform-baseline)

Terraform module which creates an Azure Web App.

## Usage

See [usage examples](./examples/).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.39.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.39.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_certificate_binding.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate_binding) | resource |
| [azurerm_app_service_custom_hostname_binding.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_custom_hostname_binding) | resource |
| [azurerm_app_service_managed_certificate.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_managed_certificate) | resource |
| [azurerm_linux_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_windows_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | The name of this Web App. | `string` | n/a | yes |
| <a name="input_app_service_plan_id"></a> [app\_service\_plan\_id](#input\_app\_service\_plan\_id) | The ID of the App Service plan to host this Web App on. | `string` | n/a | yes |
| <a name="input_application_logs_file_system_level"></a> [application\_logs\_file\_system\_level](#input\_application\_logs\_file\_system\_level) | The level of application logs to be enabled. Possible values include "Verbose", "Information", "Warning" and "Error". | `string` | `"Error"` | no |
| <a name="input_auth_settings_active_directory"></a> [auth\_settings\_active\_directory](#input\_auth\_settings\_active\_directory) | A list of authentication settings using the Active Directory provider to configure for this web app. | <pre>list(object({<br>    client_id                  = string<br>    client_secret_setting_name = optional(string, "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET")<br>  }))</pre> | `[]` | no |
| <a name="input_auth_settings_enabled"></a> [auth\_settings\_enabled](#input\_auth\_settings\_enabled) | Should the built-in authentication settings be enabled for this Web App? | `bool` | `false` | no |
| <a name="input_container_registry_managed_identity_client_id"></a> [container\_registry\_managed\_identity\_client\_id](#input\_container\_registry\_managed\_identity\_client\_id) | The client ID of the Managed Identity that will be used to pull from the Container Registry. | `string` | `null` | no |
| <a name="input_container_registry_use_managed_identity"></a> [container\_registry\_use\_managed\_identity](#input\_container\_registry\_use\_managed\_identity) | Should connections to Container Registry use Managed Identity? | `bool` | `false` | no |
| <a name="input_custom_hostname_bindings"></a> [custom\_hostname\_bindings](#input\_custom\_hostname\_bindings) | A list of custom hostnames to bind to this Web App. | <pre>map(object({<br>    hostname  = string<br>    ssl_state = optional(string, "SniEnabled")<br>  }))</pre> | `{}` | no |
| <a name="input_diagnostic_setting_enabled_log_categories"></a> [diagnostic\_setting\_enabled\_log\_categories](#input\_diagnostic\_setting\_enabled\_log\_categories) | A list of log categories to be enabled for this diagnostic setting. | `list(string)` | <pre>[<br>  "AppServiceHTTPLogs",<br>  "AppServiceConsoleLogs",<br>  "AppServiceAppLogs",<br>  "AppServiceAuditLogs",<br>  "AppServiceIPSecAuditLogs",<br>  "AppServicePlatformLogs"<br>]</pre> | no |
| <a name="input_http_logs_file_system_retention_in_days"></a> [http\_logs\_file\_system\_retention\_in\_days](#input\_http\_logs\_file\_system\_retention\_in\_days) | The retention period in days before HTTP logs are deleted from the file system. | `number` | `0` | no |
| <a name="input_http_logs_file_system_retention_in_mb"></a> [http\_logs\_file\_system\_retention\_in\_mb](#input\_http\_logs\_file\_system\_retention\_in\_mb) | The maximum size in megabytes that HTTP logs can use before being deleted from the file system. | `number` | `35` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | The identity or identities to configure for this Web App. | <pre>object({<br>    type         = optional(string, "SystemAssigned")<br>    identity_ids = optional(list(string), [])<br>  })</pre> | `null` | no |
| <a name="input_key_vault_reference_identity_id"></a> [key\_vault\_reference\_identity\_id](#input\_key\_vault\_reference\_identity\_id) | The ID of the Managed Identity that will be used to fetch app settings sourced from Key Vault. | `string` | `null` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | The kind of Web App to create. | `string` | `"Linux"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location to create the resources in. | `string` | n/a | yes |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | The type of log analytics destination to use for this Log Analytics Workspace. | `string` | `null` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID of the Log Analytics workspace to send diagnostics to. | `string` | n/a | yes |
| <a name="input_logs_detailed_error_messages"></a> [logs\_detailed\_error\_messages](#input\_logs\_detailed\_error\_messages) | Should detailed error messages be enabled for logs? | `bool` | `false` | no |
| <a name="input_logs_failed_request_tracing"></a> [logs\_failed\_request\_tracing](#input\_logs\_failed\_request\_tracing) | Should failed request tracing be enabled for logs? | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to create the resources in. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name for this service plan. | `string` | `"B1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_virtual_network_subnet_id"></a> [virtual\_network\_subnet\_id](#input\_virtual\_network\_subnet\_id) | The ID of the virtual network subnet to configure for this Web App. | `string` | `null` | no |
| <a name="input_vnet_route_all_enabled"></a> [vnet\_route\_all\_enabled](#input\_vnet\_route\_all\_enabled) | Should all outbound traffic have NAT Gateways, Network Security Groups and User Defined Routes applied? | `bool` | `false` | no |
| <a name="input_websockets_enabled"></a> [websockets\_enabled](#input\_websockets\_enabled) | Should web sockets be enabled for this Web App? | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_id"></a> [app\_id](#output\_app\_id) | The ID of this Web App. |
| <a name="output_app_name"></a> [app\_name](#output\_app\_name) | The name of this Web App. |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | The principal ID of the system-assigned identity of this Web App. |
| <a name="output_identity_tenant_id"></a> [identity\_tenant\_id](#output\_identity\_tenant\_id) | The tenant ID of the system-assigned identity of this Web App. |
<!-- END_TF_DOCS -->