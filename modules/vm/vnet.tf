resource "azurerm_resource_group" "rg-vm" {
    name = var.resource_group
    location = var.location
    tags = var.tags
    }
#### two security groups
resource "azurerm_network_security_group" "nsg1" {
    name                = var.security_group
    location            = var.location
    resource_group_name = azurerm_resource_group.rg-vm.name
    depends_on          = [azurerm_resource_group.rg-vm]
    tags                = var.tags
}

resource "azurerm_virtual_network" "vnet-vm" {
    name                = var.azurerm_virtual_network
    location            = var.location
    address_space       = var.address_space
    resource_group_name = azurerm_resource_group.rg-vm.name
    #dns_servers         = ["10.0.0.4", "10.0.0.5"]
    subnet {
     name          = var.subnet_name
     address_prefix = var.address_prefixes
    security_group = azurerm_network_security_group.nsg1.id
    }
    tags           = var.tags
    depends_on     = [azurerm_network_security_group.nsg1]
}
resource "azurerm_route_table" "vm_route_table-01" {
    name = "vm_route_table-01"
    location = var.location
    resource_group_name = var.resource_group
    route {
    name = "route-01"
    address_prefix = "10.100.0.0/14"
    next_hop_type = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.1.1"
}
 depends_on = [azurerm_resource_group.rg-vm]
 tags = var.tags
}
resource "azurerm_subnet_route_table_association" "vm" {
    subnet_id      = data.azurerm_subnet.subnet1.id
    route_table_id = azurerm_route_table.vm_route_table-01.id
    depends_on     = [data.azurerm_subnet.subnet1, azurerm_route_table.vm_route_table-01]
}
data "azurerm_subnet" "subnet1" {
  name                 = var.subnet_name
  virtual_network_name = var.azurerm_virtual_network
  resource_group_name  = var.resource_group
  depends_on           = [azurerm_virtual_network.vnet-vm]
}



resource "azurerm_network_interface" "main" {
  name                = "nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = data.azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}