data "azurerm_resource_group" "main" {
  name = "alexlab-01"
}

data "azurerm_subnet" "main" {
  name                 = "alexlab-01-subnet"
  virtual_network_name = "alexlab-01-vnet-us-central"
  resource_group_name  = data.azurerm_resource_group.main.name
}

data "azurerm_network_security_group" "main" {
  name                = "lab-inbound"
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_user_assigned_identity" "main" {
  name                = "alexlab-01"
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_ssh_public_key" "main" {
  name                = "epam-tf-ssh-key"
  resource_group_name = data.azurerm_resource_group.main.name
}
