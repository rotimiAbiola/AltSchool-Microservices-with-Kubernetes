# AltSchool-Microservices-with-Kubernetes

Error: authorization.RoleAssignmentsClient#Create: Failure responding to request: StatusCode=400 -- Original Error: autorest/azure: Service returned an error. Status=400 Code="InvalidPrincipalId" Message="A valid principal ID must be provided for role assignment."
│
│   with azurerm_role_assignment.aks_identity_operator,
│   on aks-identity.tf line 16, in resource "azurerm_role_assignment" "aks_identity_operator":
│   16: resource "azurerm_role_assignment" "aks_identity_operator" {
│
╵
╷
│ Error: checking for presence of existing Key "acr-encryption-key" (Key Vault "https://project-kv-wyizw6.vault.azure.net/"): keyvault.BaseClient#GetKey: Failure responding to request: StatusCode=403 -- Original Error: autorest/azure: Service returned an error. Status=403 Code="Forbidden" Message="Caller is not authorized to perform action on resource.\r\nIf role assignments, deny assignments or role definitions were changed recently, please observe propagation time.\r\nCaller: appid=04b07795-8ddb-461a-bbee-02f9e1bf7b46;oid=47016696-c2f7-4b61-afc8-5e64c2ab608e;iss=https://sts.windows.net/9c1de1f2-cba6-4355-b7ed-96777eba6578/\r\nAction: 'Microsoft.KeyVault/vaults/keys/read'\r\nResource: '/subscriptions/0f519205-ea0a-4bce-a035-3cbb51074fe9/resourcegroups/aks_cluster/providers/microsoft.keyvault/vaults/project-kv-wyizw6/keys/acr-encryption-key'\r\nAssignment: (not found)\r\nDenyAssignmentId: null\r\nDecisionReason: null \r\nVault: project-kv-wyizw6;location=canadacentral\r\n" InnerError={"code":"ForbiddenByRbac"}
│
│   with azurerm_key_vault_key.acr_key,
│   on external-svc.tf line 18, in resource "azurerm_key_vault_key" "acr_key":
│   18: resource "azurerm_key_vault_key" "acr_key" {
│
╵
Releasing state lock. This may take a few moments...