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
  source = "github.com/equinor/terraform-azurerm-vault"

  application = local.application
  environment = local.environment

  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  log_analytics_workspace_id = azurerm_log_analytics_workspace.example.id
}

module "acr" {
  source = "github.com/equinor/terraform-azurerm-acr"

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

  azuread_client_secret = {
    vault_name  = module.vault.key_vault_name
    secret_name = "ClientSecret"
  }

  acr_identity_client_id = module.acr.user_assigned_identity_client_id
  acr_identity_id        = module.acr.user_assigned_identity_id
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