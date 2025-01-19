# AKS Cluster with VNet integration
resource "azurerm_kubernetes_cluster" "main" {
  name                = "project-aks"
  location            = azurerm_resource_group.cluster.location
  resource_group_name = azurerm_resource_group.cluster.name
  dns_prefix          = "project"
  kubernetes_version  = "1.30.0"

  # For production change to "Standard"
  sku_tier = "Free"

  oidc_issuer_enabled               = true
  workload_identity_enabled         = true
  role_based_access_control_enabled = true
  local_account_disabled            = false
  automatic_upgrade_channel         = "stable"
  private_cluster_enabled           = false

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_A2_v2"
    vnet_subnet_id = azurerm_subnet.aks.id

    # Enable auto-scaling if needed
    auto_scaling_enabled = true
    min_count            = 1
    max_count            = 5
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "calico"
    dns_service_ip = "10.0.3.10"
    service_cidr   = "10.0.3.0/24"
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.aks_identity.id
    ]
  }

  depends_on = [
    azurerm_role_assignment.network_contributor
  ]

  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = false
    secret_rotation_interval = "2m"
  }

  # maintenance windows
  maintenance_window_auto_upgrade {
    frequency   = "Weekly"
    interval    = 1
    duration    = 4
    day_of_week = "Saturday"
    utc_offset  = "+01:00"
    start_time  = "02:00"
  }

}
