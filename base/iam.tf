resource "azurerm_user_assigned_identity" "main" {
  name                = local.resource_group_name
  location            = local.location
  resource_group_name = local.resource_group_name

  tags = local.tags
}

resource "azurerm_role_assignment" "main" {
  scope              = azurerm_storage_account.main.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.main.principal_id
  principal_type     = "ServicePrincipal"
}
