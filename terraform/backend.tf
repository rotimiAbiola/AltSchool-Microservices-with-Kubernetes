terraform {
  backend "azurerm" {
    resource_group_name  = "AltSchool"
    storage_account_name = "examstorage456"
    container_name       = "terraform"
    key                  = "prod.terraform.tfstate"
  }
}