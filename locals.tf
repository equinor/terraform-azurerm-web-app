locals {
  is_windows = var.kind == "Windows"

  https_only = true

  container_registry_use_managed_identity = coalesce(var.container_registry_use_managed_identity, var.container_registry_managed_identity_client_id != null)

  # The following values are set automatically by Azure.
  # Set explicitly to prevent Terraform from detecting them as "changes made outside of Terraform".
  auth_settings_enabled                            = true
  auth_settings_require_authentication             = true
  auth_settings_default_provider                   = "azureactivedirectory"
  auth_settings_excluded_paths                     = []
  auth_settings_token_store_enabled                = true
  auth_settings_allowed_external_redirect_urls     = []
  active_directory_tenant_auth_endpoint            = coalesce(var.active_directory_tenant_auth_endpoint, "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}/v2.0")
  active_directory_allowed_audiences               = var.active_directory_client_id != null ? ["api://${var.active_directory_client_id}"] : []
  active_directory_allowed_groups                  = []
  active_directory_allowed_applications            = []
  active_directory_allowed_identities              = []
  active_directory_jwt_allowed_client_applications = []
  active_directory_jwt_allowed_groups              = []

  # Auto assign Key Vault reference identity
  identity_ids = concat(compact([var.key_vault_reference_identity_id]), var.identity_ids)

  # If system_assigned_identity_enabled is true, value is "SystemAssigned".
  # If identity_ids is non-empty, value is "UserAssigned".
  # If system_assigned_identity_enabled is true and identity_ids is non-empty, value is "SystemAssigned, UserAssigned".
  identity_type = join(", ", compact([var.system_assigned_identity_enabled ? "SystemAssigned" : "", length(local.identity_ids) > 0 ? "UserAssigned" : ""]))

  web_app = local.is_windows ? azurerm_windows_web_app.this[0] : azurerm_linux_web_app.this[0]
}
