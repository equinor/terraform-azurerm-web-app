# terraform-azurerm-web-app

Terraform module which creates an Azure Web App for Containers.

## Usage

```terraform
provider "azurerm" {
  features {}
}

locals {
  application = "my-app"
  environment = "example"
}

resource "azurerm_resource_group" "example" {
  name     = "rg-${local.application}-${local.environment}"
  location = "northeurope"
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = "log-${local.application}-${local.environment}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Free"
}

module "vault" {
  source = "github.com/equinor/terraform-azurerm-vault?ref=v3.0.0"

  application = local.application
  environment = local.environment

  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
}

resource "azurerm_key_vault_secret" "example" {
  name         = "ClientSecret"
  value        = "my-secret"
  key_vault_id = module.vault.key_vault_id
}

module "acr" {
  source = "github.com/equinor/terraform-azurerm-acr?ref=v2.0.0"

  application = local.application
  environment = local.environment

  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

module "web_app" {
  source = "github.com/equinor/terraform-azurerm-web-app"

  application = local.application
  environment = local.environment

  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  azuread_client_id = "6b5fbe59-9c49-488f-959f-82cada7abf14"
  key_vault_name    = module.vault.key_vault_name

  managed_identity_client_id = module.acr.managed_identity_client_id
  managed_identity_id        = module.acr.managed_identity_id
}

resource "azurerm_key_vault_access_policy" "example" {
  key_vault_id = module.vault.key_vault_id
  tenant_id    = module.web_app.app_service_identity_tenant_id
  object_id    = module.web_app.app_service_identity_principal_id

  secret_permissions = ["Get"]
}
```

## Test

### Prerequisites

- Install the latest version of [Go](https://go.dev/dl/).
- Install [Terraform](https://www.terraform.io/downloads).
- Configure your Azure credentials using one of the [options supported by the AzureRM provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#authenticating-to-azure).

### Run test

```bash
cd ./test/
go test -v -timeout 60m
```

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
| [azurerm_app_service_certificate_binding.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_certificate_binding) | resource |
| [azurerm_app_service_custom_hostname_binding.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_custom_hostname_binding) | resource |
| [azurerm_app_service_managed_certificate.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_managed_certificate) | resource |
| [azurerm_linux_web_app.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app) | resource |
| [azurerm_service_plan.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_service_hostnames"></a> [app\_service\_hostnames](#input\_app\_service\_hostnames) | A list of custom hostnames to use for the App Service. | `list(string)` | `[]` | no |
| <a name="input_app_service_name"></a> [app\_service\_name](#input\_app\_service\_name) | A custom name for the App Service. | `string` | `null` | no |
| <a name="input_app_service_plan_name"></a> [app\_service\_plan\_name](#input\_app\_service\_plan\_name) | A custom name for the App Service Plan. | `string` | `null` | no |
| <a name="input_app_service_plan_sku_name"></a> [app\_service\_plan\_sku\_name](#input\_app\_service\_plan\_sku\_name) | The SKU name for the App Service Plan. | `string` | `"B1"` | no |
| <a name="input_app_service_settings"></a> [app\_service\_settings](#input\_app\_service\_settings) | A mapping of settings for the App Service. | `map(string)` | `{}` | no |
| <a name="input_application"></a> [application](#input\_application) | The application to create the resources for. | `string` | n/a | yes |
| <a name="input_azuread_client_id"></a> [azuread\_client\_id](#input\_azuread\_client\_id) | The client ID of the App Registration to use for Azure AD authentication. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to create the resources for. | `string` | n/a | yes |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | The name of the Key Vault where the App Registration client secret is stored. | `string` | n/a | yes |
| <a name="input_key_vault_secret_name"></a> [key\_vault\_secret\_name](#input\_key\_vault\_secret\_name) | The name of the Key Vault Secret containing the App Registration client secret. | `string` | `"ClientSecret"` | no |
| <a name="input_location"></a> [location](#input\_location) | The supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_managed_identity_client_id"></a> [managed\_identity\_client\_id](#input\_managed\_identity\_client\_id) | The client ID of the Managed Identity that will be used to pull from the Container Registry. | `string` | n/a | yes |
| <a name="input_managed_identity_id"></a> [managed\_identity\_id](#input\_managed\_identity\_id) | The ID of the Managed Identity that will be used to pull from the Container Registry. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the resources. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_service_id"></a> [app\_service\_id](#output\_app\_service\_id) | The ID of the App Service. |
| <a name="output_app_service_identity_principal_id"></a> [app\_service\_identity\_principal\_id](#output\_app\_service\_identity\_principal\_id) | The principal ID of the App Service Identity. |
| <a name="output_app_service_identity_tenant_id"></a> [app\_service\_identity\_tenant\_id](#output\_app\_service\_identity\_tenant\_id) | The tenant ID of the App Service Identity. |
| <a name="output_app_service_name"></a> [app\_service\_name](#output\_app\_service\_name) | The name of the App Service. |
| <a name="output_app_service_plan_id"></a> [app\_service\_plan\_id](#output\_app\_service\_plan\_id) | The ID of the App Service Plan. |
| <a name="output_app_service_plan_name"></a> [app\_service\_plan\_name](#output\_app\_service\_plan\_name) | The name of the App Service Plan. |
<!-- END_TF_DOCS -->