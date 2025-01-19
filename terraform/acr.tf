# Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                          = "projectacr${random_string.unique.result}"
  resource_group_name           = azurerm_resource_group.cluster.name
  location                      = azurerm_resource_group.cluster.location
  sku                           = "Premium"
  admin_enabled                 = true # Disable admin account for security
  data_endpoint_enabled         = false
  public_network_access_enabled = true
  network_rule_bypass_option    = "AzureServices"

  network_rule_set {
    default_action = "Deny"
  }

  # encryption {
  #   key_vault_key_id   = azurerm_key_vault_key.main.id
  #   identity_client_id = azurerm_user_assigned_identity.acr_identity.client_id
  # }
}