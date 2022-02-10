tags = {
  Environment = "Dev"
  ProjectName = "iot-project"
  Owner       = "user@example.com"
  terraform   = "yes" }


location                  = "East US"
resource_group            = "rg-vm-del"
azurerm_virtual_machine   = "vm"
subnet_name               = "vm-subnet"
azurerm_virtual_network   = "vnet-vm"
security_group            = "vm-sg"
address_space             = "10.0.0.0/16"
address_prefixes          = "10.0.1.0/24"
publicip                  = "publicip"

