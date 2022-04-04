# Azure Web App Terraform module

Terraform module which creates an Azure Web App for containers

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Application name, used to generate resource names | `string` | n/a | yes |
| <a name="input_app_service_name"></a> [app\_service\_name](#input\_app\_service\_name) | Name of app service to create, generated if not set | `string` | `null` | no |
| <a name="input_app_service_plan_name"></a> [app\_service\_plan\_name](#input\_app\_service\_plan\_name) | Name of app service plan to create, generated if not set | `string` | `null` | no |
| <a name="input_app_service_plan_sku_name"></a> [app\_service\_plan\_sku\_name](#input\_app\_service\_plan\_sku\_name) | SKU name of app service plan to create | `string` | `"B1"` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | App settings for the web app | `map(string)` | `{}` | no |
| <a name="input_azuread_client_id"></a> [azuread\_client\_id](#input\_azuread\_client\_id) | Client ID of app registration to use for Azure AD authentication | `string` | n/a | yes |
| <a name="input_azuread_client_secret"></a> [azuread\_client\_secret](#input\_azuread\_client\_secret) | Client secret of app registration to use for Azure AD authentication | <pre>object({<br>    vault_name  = string<br>    secret_name = string<br>  })</pre> | n/a | yes |
| <a name="input_container_registry_managed_identity_client_id"></a> [container\_registry\_managed\_identity\_client\_id](#input\_container\_registry\_managed\_identity\_client\_id) | Client ID of managed identity that will be used to pull image from container registry | `string` | n/a | yes |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Environment name, used to generate resource names | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location to create resources in | `string` | n/a | yes |
| <a name="input_managed_identity_ids"></a> [managed\_identity\_ids](#input\_managed\_identity\_ids) | IDs of managed identities to be assigned to the web app | `list(string)` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of resource group to create resources in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_service_id"></a> [app\_service\_id](#output\_app\_service\_id) | ID of the created app service |
| <a name="output_app_service_managed_identity"></a> [app\_service\_managed\_identity](#output\_app\_service\_managed\_identity) | Principal ID and tenant ID of the created app service |
| <a name="output_app_service_name"></a> [app\_service\_name](#output\_app\_service\_name) | Name of the created app service |
| <a name="output_app_service_plan_id"></a> [app\_service\_plan\_id](#output\_app\_service\_plan\_id) | ID of the created app service plan |
| <a name="output_app_service_plan_name"></a> [app\_service\_plan\_name](#output\_app\_service\_plan\_name) | Name of the created app service plan |
<!-- END_TF_DOCS -->