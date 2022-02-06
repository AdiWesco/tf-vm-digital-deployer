variable "azurerm_virtual_machine" {
    default = "vm"
    description = "enter vm name"
  
}
variable "resource_group" {
    default = "rg-vm"
    description = "enter rg name"
  
}
variable "location" {
  default = "eastus"
  description = "location name"
}
variable "subnet_id" {
    default = ""
    description = "enter subnet_id"
  
}
variable "tags" {
    type = map(string)
    default = {
    Environment  = "Production"
    ProjectName  = "demo-project"
    Owner        = "user@example.com"
    terraform    = "yes"
  
    }
  
}
variable "subnet_name" {
  default = "subnet1"
}
variable "azurerm_virtual_network" {
  default = "vnet-vm"
  description = "enter vnet name"
}
variable "managed_disk" {
    default = "disk1"
    description = "additional storage disk"
  
}