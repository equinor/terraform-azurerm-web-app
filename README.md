# Azure Web App Terraform module

Terraform module which creates an Azure Web App for Containers.

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_service_plan"></a> [service\_plan](#module\_service\_plan) | ./modules/service-plan | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_certificate_binding.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate_binding) | resource |
| [azurerm_app_service_custom_hostname_binding.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_custom_hostname_binding) | resource |
| [azurerm_app_service_managed_certificate.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_managed_certificate) | resource |
| [azurerm_linux_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_client_id"></a> [aad\_client\_id](#input\_aad\_client\_id) | The client ID of the App Registration to use for Azure AD authentication. | `string` | n/a | yes |
| <a name="input_aad_client_secret_setting_name"></a> [aad\_client\_secret\_setting\_name](#input\_aad\_client\_secret\_setting\_name) | The name of the app setting that contains the client secret of the App Registration to use for Azure AD authentication. | `string` | `"AAD_CLIENT_SECRET"` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | The name of this Web App. | `string` | `null` | no |
| <a name="input_custom_hostnames"></a> [custom\_hostnames](#input\_custom\_hostnames) | A list of custom hostnames to bind to this Web App. | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The location to create the resources in. | `string` | n/a | yes |
| <a name="input_managed_identity_client_id"></a> [managed\_identity\_client\_id](#input\_managed\_identity\_client\_id) | The client ID of the Managed Identity that will be used to pull from the Container Registry. | `string` | n/a | yes |
| <a name="input_managed_identity_id"></a> [managed\_identity\_id](#input\_managed\_identity\_id) | The ID of the Managed Identity that will be used to pull from the Container Registry. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to create the resources in. | `string` | n/a | yes |
| <a name="input_service_plan_name"></a> [service\_plan\_name](#input\_service\_plan\_name) | The name of this Web App service plan. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name for this service plan. | `string` | `"B1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aad_client_secret_setting_name"></a> [aad\_client\_secret\_setting\_name](#output\_aad\_client\_secret\_setting\_name) | The name of the app setting that contains the client secret of the App Registration to use for Azure AD authentication. |
| <a name="output_app_id"></a> [app\_id](#output\_app\_id) | The ID of this Web App. |
| <a name="output_app_name"></a> [app\_name](#output\_app\_name) | The name of this Web App. |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | The principal ID of the system-assigned identity of this Web App. |
| <a name="output_identity_tenant_id"></a> [identity\_tenant\_id](#output\_identity\_tenant\_id) | The tenant ID of the system-assigned identity of this Web App. |
| <a name="output_service_plan_id"></a> [service\_plan\_id](#output\_service\_plan\_id) | The ID of this Web App service plan. |
| <a name="output_service_plan_name"></a> [service\_plan\_name](#output\_service\_plan\_name) | The name of this Web App service plan. |
<!-- END_TF_DOCS -->