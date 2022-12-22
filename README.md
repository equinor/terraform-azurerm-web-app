# Azure Web App Terraform module

Terraform module which creates an Azure Web App.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_linux_app"></a> [linux\_app](#module\_linux\_app) | ./modules/linux-app | n/a |
| <a name="module_service_plan"></a> [service\_plan](#module\_service\_plan) | ./modules/service-plan | n/a |
| <a name="module_windows_app"></a> [windows\_app](#module\_windows\_app) | ./modules/windows-app | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apps"></a> [apps](#input\_apps) | A map of identifier => Linux/Windows Web App objects | <pre>map(object({<br>    name                            = string<br>    auth_settings_enabled           = optional(bool)<br>    aad_client_id                   = string<br>    aad_client_secret_setting_name  = optional(string)<br>    key_vault_reference_identity_id = optional(string)<br>    websockets_enabled              = optional(bool)<br>    acr_managed_identity_client_id  = optional(string)<br>    managed_identity_ids            = optional(list(string))<br>    custom_hostnames                = optional(list(string))<br>  }))</pre> | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | The location to create the resources in. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID of the Log Analytics workspace to send diagnostics to. | `string` | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The OS type for the apps to be hosted on this Web App service plan. | `string` | `"Linux"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to create the resources in. | `string` | n/a | yes |
| <a name="input_service_plan_name"></a> [service\_plan\_name](#input\_service\_plan\_name) | The name of this Web App service plan. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name for this service plan. | `string` | `"B1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aad_client_secret_setting_names"></a> [aad\_client\_secret\_setting\_names](#output\_aad\_client\_secret\_setting\_names) | A mapping of the app setting name where the Azure AD client secret must be stored for each Web App. |
| <a name="output_app_ids"></a> [app\_ids](#output\_app\_ids) | A mapping of Web App IDs for this service plan. |
| <a name="output_app_names"></a> [app\_names](#output\_app\_names) | A mapping of Web App names for this service plan. |
| <a name="output_identity_principal_ids"></a> [identity\_principal\_ids](#output\_identity\_principal\_ids) | A mapping of system-assigned identity IDs of the created Web Apps. |
| <a name="output_service_plan_id"></a> [service\_plan\_id](#output\_service\_plan\_id) | The ID of this Web App service plan. |
| <a name="output_service_plan_name"></a> [service\_plan\_name](#output\_service\_plan\_name) | The name of this Web App service plan. |
<!-- END_TF_DOCS -->