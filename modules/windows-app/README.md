# Azure Windows Web App Terraform sub-module

Terraform sub-module which creates an Azure Windows Web App.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_certificate_binding.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate_binding) | resource |
| [azurerm_app_service_custom_hostname_binding.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_custom_hostname_binding) | resource |
| [azurerm_app_service_managed_certificate.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_managed_certificate) | resource |
| [azurerm_windows_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_web_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aad_client_id"></a> [aad\_client\_id](#input\_aad\_client\_id) | The client ID of the App Registration to use for Azure AD authentication. | `string` | n/a | yes |
| <a name="input_aad_client_secret_setting_name"></a> [aad\_client\_secret\_setting\_name](#input\_aad\_client\_secret\_setting\_name) | The name of the app setting that should contain the client secret to use for Azure AD authentication. | `string` | `"AAD_CLIENT_SECRET"` | no |
| <a name="input_acr_managed_identity_client_id"></a> [acr\_managed\_identity\_client\_id](#input\_acr\_managed\_identity\_client\_id) | The client ID of the Managed Identity that will be used to pull from the Container Registry. | `string` | `null` | no |
| <a name="input_auth_settings_enabled"></a> [auth\_settings\_enabled](#input\_auth\_settings\_enabled) | Should authentication be enabled for this Windows Web App? | `bool` | `true` | no |
| <a name="input_custom_hostnames"></a> [custom\_hostnames](#input\_custom\_hostnames) | A list of custom hostnames to bind to this Windows Web App. | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The location to create the resources in. | `string` | n/a | yes |
| <a name="input_managed_identity_ids"></a> [managed\_identity\_ids](#input\_managed\_identity\_ids) | The IDs of the Managed Identities to assign to this Windows Web App. | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of this Windows Web App. | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to create the resources in. | `string` | n/a | yes |
| <a name="input_service_plan_id"></a> [service\_plan\_id](#input\_service\_plan\_id) | The ID of the service plan to create this Windows Web App for. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aad_client_secret_setting_name"></a> [aad\_client\_secret\_setting\_name](#output\_aad\_client\_secret\_setting\_name) | The name of the app setting that should contain the client secret to use for Azure AD authentication. |
| <a name="output_id"></a> [id](#output\_id) | The ID of this Windows Web App. |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | The principal ID of the system-assigned identity of this Windows Web App. |
| <a name="output_identity_tenant_id"></a> [identity\_tenant\_id](#output\_identity\_tenant\_id) | The tenant ID of the system-assigned identity of this Windows Web App. |
| <a name="output_name"></a> [name](#output\_name) | The name of this Windows Web App. |
<!-- END_TF_DOCS -->