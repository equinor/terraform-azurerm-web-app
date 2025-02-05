# Terraform module for Azure Web App

[![GitHub License](https://img.shields.io/github/license/equinor/terraform-azurerm-web-app)](https://github.com/equinor/terraform-azurerm-web-app/blob/main/LICENSE)
[![GitHub Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-web-app)](https://github.com/equinor/terraform-azurerm-web-app/releases/latest)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)
[![SCM Compliance](https://scm-compliance-api.radix.equinor.com/repos/equinor/terraform-azurerm-web-app/badge)](https://developer.equinor.com/governance/scm-policy/)

Terraform module which creates Azure Web App resources.

## Features

- HTTPS enforced.
- Public network access denied by default.
- Managed certificates automatically created for custom hostnames.
- Application logging enabled (automatically disabled after 12 hours, see [notes](#application-logging)).
- Audit logs sent to given Log Analytics workspace by default.
- Changes to app settings `BUILD`, `BUILD_NUMBER` and `BUILD_ID` ignored, allowing them to be configured outside of Terraform (commonly in a CI/CD pipeline).

## Prerequisites

- Install [Terraform](https://developer.hashicorp.com/terraform/install).
- Install [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).

## Usage

1. Login to Azure:

    ```console
    az login
    ```

1. Create a Terraform configuration file `main.tf` and add the following example configuration:

    ```terraform
    provider "azurerm" {
      features {}
    }

    module "web_app" {
      source  = "equinor/web-app/azurerm"
      version = "~> 15.13"

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

1. Install required provider plugins and modules:

    ```console
    terraform init
    ```

1. Apply the Terraform configuration:

    ```console
    terraform apply
    ```

## Notes

### Application logging

- Application logging is enabled by default, however it'll be automatically disabled after 12 hours.
- It can be re-enabled at any time by running the following Azure CLI command:

    ```console
    az webapp log config -n <APP_NAME> -g <RESOURCE_GROUP_NAME> --application-logging filesystem
    ```

## Development

1. Login to Azure:

    ```bash
    az login
    ```

1. Set environment variables:

    ```bash
    export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
    export TF_VAR_resource_group_name="<RESOURCE_GROUP_NAME>"
    export TF_VAR_location="<LOCATION>"
    ```

## Testing

1. Change to the test directory:

    ```console
    cd test
    ```

1. Login to Azure:

    ```console
    az login
    ```

1. Set active subscription:

    ```console
    az account set -s <SUBSCRIPTION_NAME_OR_ID>
    ```

1. Run tests:

    ```console
    go test -timeout 60m
    ```

## Contributing

See [Contributing guidelines](https://github.com/equinor/terraform-baseline/blob/main/CONTRIBUTING.md).
