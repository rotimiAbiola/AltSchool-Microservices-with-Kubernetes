# Add this data source to get current Azure client configuration
data "azurerm_client_config" "current" {}

data "azuread_client_config" "current" {}

resource "azurerm_resource_group" "terraform" {
  name     = "terraform_rg"
  location = var.location
}

resource "azurerm_resource_group" "networking" {
  name     = "network_rg"
  location = var.location
}

resource "azurerm_resource_group" "cluster" {
  name     = "aks_cluster"
  location = var.location
}

resource "random_pet" "prefix" {
  length = 1
}

resource "random_string" "unique" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_storage_account" "storage" {
  name                     = "tfstate${random_pet.prefix.id}"
  resource_group_name      = azurerm_resource_group.terraform.name
  location                 = azurerm_resource_group.terraform.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = "private"
}
