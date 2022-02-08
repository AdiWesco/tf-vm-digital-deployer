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
    Environment  = "Dev"
    ProjectName  = "iot-project"
    Owner        = "user@example.com"
    terraform    = "yes"
  
    }
  
}
variable "subnet_name" {
  default = "vm-subnet"
}
variable "managed_disk" {
    default = "disk1"
    description = "additional storage disk"
  
}


variable "azurerm_virtual_network" {
  default = "vnet-vm"
  description = "enter vnet name"
}
variable "security_group" {
  description = "enter security group"
  default = "security-group"
}
variable "address_space" {
  type = list(string)
  default = ["10.0.0.0/16"]
  description = "address space here"
}
variable "address_prefixes" {
    type = list(string)
    default = ["10.0.1.0/24"]
    description = "address prefixes here"
}

variable "publicip" {
  default = "publicip"
}