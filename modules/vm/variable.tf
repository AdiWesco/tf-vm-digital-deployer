
variable "resource_group" {
    default = "rg-vm-del"
    description = "enter rg name"
  
}
variable "location" {
  default = "eastus"
  description = "location name"
}
variable "azurerm_virtual_machine" {
    default = "vm"
    description = "enter vm name"
  
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
  default = "sg-vm"
}
variable "address_space" {
  type = list(string)
  default = ["10.0.0.0/16"]
  description = "address space here"
}
variable "address_prefixes" {
    type = string
    default = "10.0.1.0/24"
    description = "address prefixes here"
}

variable "publicip" {
  default = "publicip"
}
variable "subnet_name" {
  default = "vm-subnet"
  }

  variable "dns_zone" {
    default = "galuctussandbox.app"
  }