output "storage_container_name" {
  value = azurerm_storage_container.container.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.main.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.main.kube_config_raw

  sensitive = true
}

output "client_id" {
  value = azuread_application.github_oidc.client_id
}

output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
} 