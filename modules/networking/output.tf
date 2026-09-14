output "network_interface_id" {
  value = azurerm_network_interface.this.id
}

output "vnet_name" {
  value = azurerm_virtual_network.this.name
}

output "subnet_id" {
  value = azurerm_subnet.this.id
}

output "public_ip_address" {
  value = var.create_public_ip ? azurerm_public_ip.this[0].ip_address : null
}
