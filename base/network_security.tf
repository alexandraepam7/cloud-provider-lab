resource "azurerm_network_security_group" "main" {
  name                = "lab-inbound"
  location            = local.location
  resource_group_name = azurerm_resource_group.main.name

  tags = local.tags
}

resource "azurerm_network_security_rule" "http_inbound" {
  name                        = "http-inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "188.25.198.179"
  destination_address_prefix  = "10.10.1.0/24"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_network_security_rule" "ssh_inbound" {
  name                        = "ssh-inbound"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "188.25.198.179"
  destination_address_prefix  = "10.10.1.0/24"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}
