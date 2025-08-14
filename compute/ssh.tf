resource "azurerm_ssh_public_key" "main" {
  name                = "epam-tf-ssh-key"
  location            = local.location
  resource_group_name = data.azurerm_resource_group.main.name
  public_key          = var.ssh_key
  tags                = local.tags
}
