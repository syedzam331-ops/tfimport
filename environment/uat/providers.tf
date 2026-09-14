terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "suri-import-rg"
    storage_account_name = "storageimportsuri"
    container_name       = "import-test"
    key                  = "terraform.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}
  subscription_id = "71a493c0-e420-4676-ab7c-c5d0ea51284a"
  use_oidc        = true
}
