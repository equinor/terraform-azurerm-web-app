# Azure App Service plan Terraform module

Terraform module which creates an Azure App Service plan.

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
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | The application to create the resources for. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to create the resources for. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the resources. | `string` | n/a | yes |
| <a name="input_service_plan_name"></a> [service\_plan\_name](#input\_service\_plan\_name) | A custom name for this Service Plan. | `string` | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name of this Service Plan. | `string` | `"B1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_plan_id"></a> [service\_plan\_id](#output\_service\_plan\_id) | n/a |
| <a name="output_service_plan_name"></a> [service\_plan\_name](#output\_service\_plan\_name) | n/a |
<!-- END_TF_DOCS -->