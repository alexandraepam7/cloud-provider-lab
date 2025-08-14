resource "azurerm_public_ip" "epam_tf_lab" {
  name                = "epam-tf-lab-pip"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "Alexandra Ghitan"
  }
}

resource "azurerm_lb" "epam_tf_lab" {
  name                = "epam-tf-lab-lb"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "publicFrontend"
    public_ip_address_id = azurerm_public_ip.epam_tf_lab.id
  }

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "Alexandra Ghitan"
  }
}

resource "azurerm_lb_backend_address_pool" "epam_tf_lab" {
  name                = "epam-tf-lab-backend-pool"
  loadbalancer_id     = azurerm_lb.epam_tf_lab.id
}

resource "azurerm_lb_probe" "epam_tf_lab" {
  name                = "epam-tf-lab-probe"
  loadbalancer_id     = azurerm_lb.epam_tf_lab.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
}

resource "azurerm_lb_rule" "epam_tf_lab" {
  name                           = "epam-tf-lab-rule"
  loadbalancer_id                = azurerm_lb.epam_tf_lab.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.epam_tf_lab.frontend_ip_configuration[0].name
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.epam_tf_lab.id]
  probe_id                       = azurerm_lb_probe.epam_tf_lab.id
}

resource "azurerm_linux_virtual_machine_scale_set" "epam_tf_lab" {
  name                = "epam-tf-lab-vmss"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  sku                 = "Standard_F2"
  instances           = 2
  admin_username      = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    public_key = data.azurerm_ssh_public_key.main.public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-LTS"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "nic-epam-tf-lab"
    primary = true

    ip_configuration {
      name                      = "ipconfig1"
      subnet_id                 = data.azurerm_subnet.main.id
      primary                   = true
    }
  }

  custom_data = filebase64("${path.module}/init.sh")

  tags = {
    Terraform = "true"
    Project   = "epam-tf-lab"
    Owner     = "Alexandra Ghitan"
  }
}
