provider "azurerm" {
  features {}
}

resource "random_id" "this" {
  byte_length = 8
}

module "log_analytics" {
  source  = "equinor/log-analytics/azurerm"
  version = "2.2.3"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "storage" {
  source  = "equinor/storage/azurerm"
  version = "12.7.2"

  account_name                 = "st${random_id.this.hex}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  log_analytics_workspace_id   = module.log_analytics.workspace_id
  shared_access_key_enabled    = true
  network_rules_default_action = "Allow"
}

resource "azurerm_storage_container" "example" {
  name                 = "example-container"
  storage_account_name = module.storage.account_name
}

resource "azurerm_service_plan" "this" {
  name                = "plan-${random_id.this.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "B1"
  os_type             = "Linux"
}

module "web_app" {
  source = "../.."

  app_name                   = "app-${random_id.this.hex}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_plan_id        = azurerm_service_plan.this.id
  log_analytics_workspace_id = module.log_analytics.workspace_id

  ip_restriction_default_action     = "Allow"
  scm_ip_restriction_default_action = "Allow"

  app_settings = {
    "STORAGE_ACCESS_KEY" = module.storage.primary_access_key
  }

  storage_accounts = [
    {
      name                    = "data"
      account_name            = module.storage.account_name
      access_key_setting_name = "STORAGE_ACCESS_KEY"
      share_name              = azurerm_storage_container.example.name
      mount_path              = "/mnt/data"
      type                    = "AzureBlob"
    }
  ]
}
