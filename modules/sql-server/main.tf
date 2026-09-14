resource "azurerm_mssql_server" "this" {
  name                           = var.name
  location                       = var.location
  resource_group_name            = var.resource_group_name
  version                        = var.sql_version
  administrator_login            = var.administrator_login
  public_network_access_enabled  = var.public_network_access_enabled

  azuread_administrator {
    login_username = var.aad_admin_login
    object_id      = var.aad_admin_object_id
  }
}

resource "azurerm_mssql_server_extended_auditing_policy" "this" {
  server_id              = azurerm_mssql_server.this.id
  enabled                = var.auditing_enabled
  log_monitoring_enabled = var.auditing_enabled
}

resource "azurerm_mssql_server_microsoft_support_auditing_policy" "this" {
  server_id              = azurerm_mssql_server.this.id
  enabled                = var.auditing_enabled
  log_monitoring_enabled = var.auditing_enabled
}

resource "azurerm_mssql_server_transparent_data_encryption" "this" {
  server_id = azurerm_mssql_server.this.id
}

resource "azurerm_mssql_server_security_alert_policy" "this" {
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mssql_server.this.name
  state               = var.security_alert_state
}

resource "azurerm_mssql_server_vulnerability_assessment" "this" {
  count = var.enable_vulnerability_assessment ? 1 : 0

  server_security_alert_policy_id = azurerm_mssql_server_security_alert_policy.this.id
  storage_container_path          = var.vulnerability_assessment_storage_path
}
