output "azure_firewall_public_ip" {
  description = "Public IP of Azure Firewall"
  value       = azurerm_public_ip.firewall_pip.ip_address
}

output "azure_firewall_private_ip" {
  description = "Private IP of Azure Firewall"
  value       = azurerm_firewall.fw.ip_configuration[0].private_ip_address
}


output "spoke_vm_private_ip" {
  description = "Private IP of spoke VM"
  value       = azurerm_network_interface.spoke_nic.private_ip_address
}

output "jumphost_public_ip" {
  description = "Public IP of jump host"
  value       = azurerm_public_ip.jumphost_pip.ip_address
}