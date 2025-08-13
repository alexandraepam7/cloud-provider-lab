#grupul de resurse
resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = local.location
  tags     = local.tags
}

#rețeaua virtuală
resource "azurerm_virtual_network" "main" {
  name                = local.vnet_name
  address_space       = ["10.10.0.0/16"]
  location            = local.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.tags
}

#subnet-ul
resource "azurerm_subnet" "main" {
  name                 = local.subnet_name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.10.1.0/24"]
}
