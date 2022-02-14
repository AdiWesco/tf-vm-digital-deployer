output "azurerm_virtual_machine" {
    value = azurerm_virtual_machine.vm
}
#output "subnet_id" {
 # value = azurerm_subnet.subnet_name
#}
output "vnet_id" {
  value = azurerm_virtual_network.vnet-vm
}