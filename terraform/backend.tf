terraform {
  backend "azurerm" {
    resource_group_name  = "terraform_rg"
    storage_account_name = "tfstatecobra"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}