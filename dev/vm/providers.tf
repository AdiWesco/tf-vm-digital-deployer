terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
<<<<<<< HEAD
}
=======
  #backend "remote" {
   # hostname     = "app.terraform.io"
    #organization = "wescodist"

    #workspaces {
      #name = "devsecops-sandbox"
      #name = "iot-sandbox"
      #prefix = "sp-sandbox"
    #}
  #}

}
provider "azurerm" {
  features {}
  #skip_provider_registration = "true"
}
>>>>>>> 7944c4c5fe4509ce796f8f19a7bb026e3de16104
