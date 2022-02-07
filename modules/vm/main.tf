resource "azurerm_resource_group" "rg-vm" {
  name     = var.resource_group
  location = var.location
}
## security group creation 
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
## vnet creation 
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

data "azurerm_subnet" "subnet1" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group
  virtual_network_name = var.azurerm_virtual_network
  depends_on = [
    azurerm_virtual_machine.vm
  ]

}

resource "azurerm_network_interface" "nic" {
  name = "nic"
  location = var.location
  resource_group_name = var.resource_group
  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_route_table" "route_table" {
  name                = "route_table-01"
  location            = var.location
  resource_group_name = var.resource_group
  route {
    name                   = "route-01"
    address_prefix         = "10.0.0.0/14"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.0.1"
  }
  depends_on = [azurerm_resource_group.rg-vm]
  tags       = var.tags
}
resource "azurerm_subnet_route_table_association" "vm_rta" {
  subnet_id      = data.azurerm_subnet.subnet1.id
  route_table_id = azurerm_route_table.route_table.id
  depends_on     = [data.azurerm_subnet.subnet1, azurerm_route_table.route_table]
}


#########    VM creation ########
resource "azurerm_virtual_machine" "vm" {
  name                  = var.azurerm_virtual_machine
  location              = var.location
  resource_group_name   = var.resource_group
  vm_size               = "Standard_DS1_v2"
  network_interface_ids = [azurerm_network_interface.nic.id]
  tags                  = var.tags 
  

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = 100
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  provisioner "remote-exec" {
    inline =[
       file("install_apache.sh")
    ]
  }
}

#additional disk
resource "azurerm_managed_disk" "disk" {
  name                 = var.managed_disk
  location             = var.location
  resource_group_name  = var.resource_group
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "100"

  tags = var.tags
}

## adding DNS
resource "azurerm_dns_zone" "example" {
  name                = "mydomain.com"
  resource_group_name = var.resource_group
}