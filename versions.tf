terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.95.0"
    }

    azapi = {
      source  = "azure/azapi"
      version = ">= 2.0"
    }
  }
}
