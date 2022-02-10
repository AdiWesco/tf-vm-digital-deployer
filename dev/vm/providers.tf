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
<<<<<<< HEAD
  #backend "remote" {
  #  hostname     = "app.terraform.io"
   # organization = "wescodist"

   # workspaces {
      #name = "devsecops-sandbox"
    #  name = "iot-sandbox"
      #prefix = "sp-sandbox"
    #}
  #}
}
=======
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
>>>>>>> ac705f5fd6257c1da37a204e2deec619eb324159
