output "service_principal_name" {
  value       = azuread_service_principal.main.display_name
}

output "service_principal_object_id" {
  value       = azuread_service_principal.main.object_id
}

output "service_principal_tenant_id" {
  value = azuread_service_principal.main.application_tenant_id
}

output "service_principal_application_id" {
  value       = azuread_service_principal.main.application_id
}

output "client_id" {
  value       = azuread_application.main.application_id
}

output "client_secret" {
  value       = azuread_service_principal_password.main.value
 
}