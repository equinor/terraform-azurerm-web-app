mock_provider "azurerm" {}

run "setup_tests" {
  module {
    source = "./test/setup"
  }
}

run "linux_app" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_name       = run.setup_tests.storage_account_name
    storage_account_key        = run.setup_tests.storage_account_key
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id
  }

  assert {
    condition     = length(azurerm_linux_web_app.this) == 1
    error_message = "Linux Web App not created"
  }

  assert {
    condition     = length(azurerm_windows_web_app.this) == 0
    error_message = "Trying to create Windows Web App"
  }
}

run "windows_app" {
  command = plan

  variables {
    app_name                   = run.setup_tests.app_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    kind                       = "Windows"
    app_service_plan_id        = run.setup_tests.app_service_plan_id
    storage_account_name       = run.setup_tests.storage_account_name
    storage_account_key        = run.setup_tests.storage_account_key
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id
  }

  assert {
    condition     = length(azurerm_windows_web_app.this) == 1
    error_message = "Windows Web App not created"
  }

  assert {
    condition     = length(azurerm_linux_web_app.this) == 0
    error_message = "Trying to create Linux Web App"
  }
}