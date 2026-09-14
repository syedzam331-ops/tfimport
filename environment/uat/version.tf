terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    # Fill in via -backend-config or a backend.hcl per environment
    # resource_group_name  = "tfstate-rg"
    # storage_account_name = "tfstatedevXXXX"
    # container_name       = "tfstate"
    # key                  = "uat.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
