provider "azurerm" {
  features {
    
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "wescodist"

    workspaces {
      #name = "devsecops-sandbox"
      name = "iot-sandbox"
      #prefix = "sp-sandbox"
    }
}
}
