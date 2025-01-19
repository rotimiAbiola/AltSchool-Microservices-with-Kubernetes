resource "azurerm_user_assigned_identity" "workload" {
  location            = azurerm_resource_group.cluster.location
  resource_group_name = azurerm_resource_group.cluster.name
  name                = "project-workload"
}

resource "azurerm_federated_identity_credential" "workload" {
  name                = azurerm_user_assigned_identity.workload.name
  resource_group_name = azurerm_resource_group.cluster.name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = azurerm_kubernetes_cluster.main.oidc_issuer_url
  parent_id           = azurerm_user_assigned_identity.workload.id
  subject             = "system:serviceaccount:prod:my-account"

  depends_on = [azurerm_kubernetes_cluster.main]
}

# Create Azure AD Application
resource "azuread_application" "github_oidc" {
  display_name = "github-oidc-app"
}

# Create service principal
resource "azuread_service_principal" "github_oidc" {
  client_id                    = azuread_application.github_oidc.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

# Create federated identity credential for each repository
resource "azuread_application_federated_identity_credential" "repo_credentials" {
  for_each = toset([
    "rotimiAbiola/infinity-circle-phonie",
    "rotimiAbiola/AltSchool-Microservices-with-Kubernetes",
    # Add more repos as needed
  ])

  application_id = azuread_application.github_oidc.id
  display_name          = "github-${replace(each.key, "/", "-")}"
  description           = "GitHub OIDC for ${each.key}"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:${each.key}"
}

# Assign contributor role to the service principal
resource "azurerm_role_assignment" "github_oidc_role" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.github_oidc.object_id
}