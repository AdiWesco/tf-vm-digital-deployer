resource "azurerm_resource_group" "rg-vm" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.security_group
  location            = var.location
  resource_group_name = var.resource_group
  depends_on          = [azurerm_resource_group.rg-vm]
  tags                = var.tags
 
}
resource "azurerm_public_ip" "publicip" {
  name                = var.publicip
  resource_group_name = var.resource_group
  location            = var.location
  allocation_method   = "Dynamic"
  #public_ip_dns       = ["vm.wesco"]
}

resource "azurerm_virtual_network" "vnet-vm" {
  name                = var.azurerm_virtual_network
  location            = var.location
  resource_group_name = var.resource_group
  address_space       = var.address_space
  dns_servers         = ["10.0.0.4"]

 
}
resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group
  virtual_network_name = var.azurerm_virtual_network
  address_prefixes     = var.address_prefixes
}

resource "azurerm_subnet_network_security_group_association" "example" {
    subnet_id                 = azurerm_subnet.subnet1.id
    network_security_group_id = azurerm_network_security_group.nsg.id
  
}

  
resource "azurerm_network_interface" "nic" {
  name                = "nic"
  location            = var.location
  resource_group_name = var.resource_group

ip_configuration {
    name              = "internal"
    subnet_id          = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}