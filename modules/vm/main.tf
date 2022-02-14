
#########    VM creation ########
resource "azurerm_virtual_machine" "vm" {
  name                  = var.azurerm_virtual_machine
  location              = var.location
  resource_group_name   = var.resource_group
  vm_size               = "Standard_DS1_v2"
  tags                  = var.tags 
  network_interface_ids = [azurerm_network_interface.main.id]

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
    inline = [file("install_apache.sh")]
  }
}

#additional disk
resource "azurerm_managed_disk" "disk" {
  name                 = var.managed_disk
  location             = var.location
  resource_group_name  = var.resource_group
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 100

  tags = var.tags
}

## adding DNS
resource "azurerm_dns_zone" "example" {
  name                = var.dns_zone
  resource_group_name = var.resource_group
  tags = var.tags
}
