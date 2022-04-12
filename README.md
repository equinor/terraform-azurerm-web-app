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

resource "azurerm_key_vault_secret" "example" {
  name         = "ClientSecret"
  value        = "my-client-secret"
  key_vault_id = module.vault.key_vault_id
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
    key_vault_name        = module.vault.key_vault_name
    key_vault_secret_name = azurerm_key_vault_secret.example.name
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
| <a name="input_acr_identity_client_id"></a> [acr\_identity\_client\_id](#input\_acr\_identity\_client\_id) | The Client ID of the User Assigned Identity to use for connections to the Azure Container Registry. | `string` | n/a | yes |
| <a name="input_acr_identity_id"></a> [acr\_identity\_id](#input\_acr\_identity\_id) | The ID of the User Assigned Identity to use for connections to the Azure Container Registry. | `string` | n/a | yes |
| <a name="input_app_service_name"></a> [app\_service\_name](#input\_app\_service\_name) | Specifies the name of the App Service. | `string` | `null` | no |
| <a name="input_app_service_plan_name"></a> [app\_service\_plan\_name](#input\_app\_service\_plan\_name) | Specifies the name of the App Service Plan. | `string` | `null` | no |
| <a name="input_app_service_plan_sku_name"></a> [app\_service\_plan\_sku\_name](#input\_app\_service\_plan\_sku\_name) | The SKU name of the App Service Plan. | `string` | `"B1"` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | A map of key-value pairs of App Settings. | `map(string)` | `{}` | no |
| <a name="input_application"></a> [application](#input\_application) | The application to create the resources for. | `string` | n/a | yes |
| <a name="input_azuread_client_id"></a> [azuread\_client\_id](#input\_azuread\_client\_id) | The ID of the Client to use to authenticate with Azure Active Directory. | `string` | n/a | yes |
| <a name="input_azuread_client_secret"></a> [azuread\_client\_secret](#input\_azuread\_client\_secret) | The secret for the Client to use to authenticate with Azure Active Directory. | <pre>object({<br>    vault_name  = string<br>    secret_name = string<br>  })</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment to create the resources for. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resources exist. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_service_id"></a> [app\_service\_id](#output\_app\_service\_id) | The ID of the App Service. |
| <a name="output_app_service_identity_principal_id"></a> [app\_service\_identity\_principal\_id](#output\_app\_service\_identity\_principal\_id) | The Principal ID associated with the System Assigned Identity of the App Service. |
| <a name="output_app_service_identity_tenant_id"></a> [app\_service\_identity\_tenant\_id](#output\_app\_service\_identity\_tenant\_id) | The Tenant ID associated with the System Assigned Identity of the App Service. |
| <a name="output_app_service_name"></a> [app\_service\_name](#output\_app\_service\_name) | The name of the App Service. |
| <a name="output_app_service_plan_id"></a> [app\_service\_plan\_id](#output\_app\_service\_plan\_id) | The ID of the App Service Plan. |
| <a name="output_app_service_plan_name"></a> [app\_service\_plan\_name](#output\_app\_service\_plan\_name) | The name of the App Service Plan. |
<!-- END_TF_DOCS -->