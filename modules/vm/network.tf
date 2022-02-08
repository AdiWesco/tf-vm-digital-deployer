resource "azurerm_resource_group" "rg-vm" {
    name     = var.resource_group
    location = var.location
}
resource "azurerm_virtual_network" "vnet-vm" {
    name                = var.azurerm_virtual_network
    address_space       = var.address_space
    location            = var.location
    resource_group_name = var.resource_group

    tags = var.tags
}

# Create subnet
resource "azurerm_subnet" "subnet1" {
    name                 = var.subnet_name
    resource_group_name  = var.resource_group
    virtual_network_name = var.azurerm_virtual_network
    address_prefixes     = var.address_prefixes
}

# Create public IPs
resource "azurerm_public_ip" "publicip" {
    name                         = var.publicip
    location                     = var.location
    resource_group_name          = var.resource_group
    allocation_method            = "Dynamic"

    tags = var.tags
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
    name                = var.security_group
    location            = var.location
    resource_group_name = var.resource_group

    security_rule {
        name                       = "HTTP"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = var.tags
}

# Create network interface
resource "azurerm_network_interface" "nic" {
    name                      = "NIC"
    location                  = var.location
    resource_group_name       = var.resource_group

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.subnet1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.publicip.id
    }

    tags = var.tags
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.nic.id
    network_security_group_id = azurerm_network_security_group.nsg.id
}