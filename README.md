# Terraform module for Azure Web App

Terraform module which creates Azure Web App resources.

## Features

- Linux Web App created by default.
- HTTPS enforced.
- Public network access denied by default.
- Managed certificates automatically created for custom hostnames.
- Application logging enabled (automatically disabled after 12 hours, see [notes](#application-logging)).
- Audit logs sent to given Log Analytics workspace by default.
- Changes to app settings `BUILD`, `BUILD_NUMBER` and `BUILD_ID` ignored, allowing them to be configured outside of Terraform (commonly in a CI/CD pipeline).

## Prerequisites

- Azure role `Contributor` at the resource group scope.
- Azure role `Web Plan Contributor` at the App Service plan scope.
- Azure role `Log Analytics Contributor` at the Log Analytics workspace scope.

## Usage

```terraform
provider "azurerm" {
  features {}
}

module "web_app" {
  source  = "equinor/web-app/azurerm"
  version = "~> 15.18"

  app_name                   = "example-app"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  app_service_plan_id        = module.app_service.plan_id
  log_analytics_workspace_id = module.log_analytics.workspace_id
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "northeurope"
}

module "app_service" {
  source  = "equinor/app-service/azurerm"
  version = "~> 2.1"

  plan_name           = "example-plan"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

module "log_analytics" {
  source  = "equinor/log-analytics/azurerm"
  version = "~> 2.3"

  workspace_name      = "example-workspace"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}
```

## Notes

### Application logging

Application logging is enabled by default, however it'll be automatically disabled after 12 hours. It can be re-enabled at any time by running the following Azure CLI command:

```console
az webapp log config -n <APP_NAME> -g <RESOURCE_GROUP_NAME> --application-logging filesystem
```

## Contributing

See [Contributing guidelines](https://github.com/equinor/terraform-baseline/blob/main/CONTRIBUTING.md).
