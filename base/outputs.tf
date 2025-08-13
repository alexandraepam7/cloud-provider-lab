output "network_name" {
  value = azurerm_virtual_network.main.name
}

output "subnet_id" {
  value = azurerm_subnet.main.id
}

output "network_security_group_id" {
  value = azurerm_network_security_group.main.id
}

output "storage_container_name" {
  value = azurerm_storage_container.main.name
}

output "storage_account_name" {
  value = azurerm_storage_account.main.name
}

output "user_managed_identity_id" {
  value = azurerm_user_assigned_identity.main.id
}
