resource "random_string" "my_numbers" {
  length  = 7
  upper   = false
  special = false
  numeric = true
}

resource "azurerm_storage_account" "main" {
  name                     = "epamtflab${random_string.my_numbers.result}"
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}

resource "azurerm_storage_container" "main" {
  name                  = "epam-tf-lab-container"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}
