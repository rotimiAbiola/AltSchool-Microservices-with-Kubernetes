# Azure Key Vault
resource "azurerm_key_vault" "main" {
  name                          = "project-kv-${random_string.unique.result}"
  location                      = azurerm_resource_group.cluster.location
  resource_group_name           = azurerm_resource_group.cluster.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = "standard"
  enable_rbac_authorization     = true
  public_network_access_enabled = false
  purge_protection_enabled      = true

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}

# Key Vault Key for ACR encryption
# resource "azurerm_key_vault_key" "main" {
#   name         = "encryption-key"
#   key_vault_id = azurerm_key_vault.main.id
#   key_type     = "RSA"
#   key_size     = 2048

#   key_opts = [
#     "decrypt",
#     "encrypt",
#     "sign",
#     "unwrapKey",
#     "verify",
#     "wrapKey",
#   ]
# }

resource "azurerm_role_assignment" "terraform_keyvault_access" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "workload_identity_keyvault" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.workload.principal_id
}

