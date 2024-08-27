provider "azurerm" {
  features {}
}

resource "azuread_application" "app_config" {
  display_name = "${var.environment}-appConfig"
}

resource "azuread_service_principal" "this" {
  client_id = azuread_application.app_config.client_id
}

resource "azuread_service_principal_password" "this" {
  service_principal_id = azuread_service_principal.this.id
}

resource "azurerm_app_configuration" "this" {
  name                       = var.app_config_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  sku                        = var.sku
  local_auth_enabled         = true
  public_network_access      = "Enabled"
  purge_protection_enabled   = false
  soft_delete_retention_days = 7
  tags                       = local.tags
}

resource "azurerm_app_configuration_key" "conf_keys" {
  for_each               = { for key in var.configuration_keys : key.key => key }
  configuration_store_id = azurerm_app_configuration.this.id
  key                    = each.value.key
  value                  = each.value.value
  content_type           = each.value.content_type
  label                  = each.value.label

  depends_on = [
    azurerm_role_assignment.app_config_data_owner
  ]
}

resource "azurerm_role_assignment" "app_config_data_owner" {
  scope                = azurerm_app_configuration.this.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}
