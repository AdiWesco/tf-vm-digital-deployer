resource "azurerm_resource_group" "rg-vm" {
  name = var.resource_group
  location = var.location
}
module "vm" {
  source = "../../modules/vm"

  #client config
  #client_secret        = var.client_secret
  #client_id            = var.client_id
  #resource_group_name = "${azurerm_resource_group.rg-vm}"
  #resource_group_name = "${var.resource_group_name}"
  address_prefixes     = var.address_prefixes
  subnet_name          = var.subnet_name
  #vnet_name           = "${var.vnet_name}"
  #subnet_id           = "${var.subnet_id}"
  depends_on           = [azurerm_resource_group.rg-vm]
  

}