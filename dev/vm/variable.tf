variable "azurerm_resource_group" {
    default = "rg-vm"
    description = "enter rg name"
}
variable "location" {
  default = "eastus"
  description = "location name"
}
variable "vnet_name" {
    default = "vnet_name"
    description = "enter vnet name"
  
}
variable "subnet_id" {
    default = ""
    description = "subnet id here"
}
variable "subnet_name" {
    default = "subnet1"
    description = "enter subnet name"
  
}
variable "address_prefixes" {
    type = list(string)
    default = ["10.0.0.0/24"]
    description = "address prefixes here"
}