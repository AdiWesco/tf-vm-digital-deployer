variable "resource_group" {
  default = "rg-vm"
}
variable "location" {
    default = "eastus"
  
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
    default = ["10.0.0.0/24"]
    description = "address prefixes here"
}

variable "vnet_subnet_id" {
  default = ""
  description = "vnet subnet id here"
}
variable "subnet_name" {
  default = "subnet1"
}
variable "publicip" {
  default = "publicip"
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