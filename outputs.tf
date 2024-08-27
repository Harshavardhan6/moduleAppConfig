output "app_config_name" {
  value       = azurerm_app_configuration.this.name
  description = "The azure app configuration name."
}

output "app_config_id" {
  value       = azurerm_app_configuration.this.id
  description = "The app config Id."
}

output "app_config_service_principal_display_name" {
  value       = azuread_service_principal.this.display_name
  description = "Name of the service principal."
}

output "deployment_client_id" {
  value       = azuread_application.app_config.client_id
  description = "Client Id"
}

output "client_secret" {
  value       = azuread_service_principal_password.this.value
  sensitive   = true
  description = "Client Secret"
}

output "service_principal_object_id" {
  value       = azuread_service_principal.this.id
  description = "Service principal Id"
}
