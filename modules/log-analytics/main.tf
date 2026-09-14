resource "azurerm_log_analytics_workspace" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
}

# Saved searches — pass as a list of objects instead of one resource block each.
resource "azurerm_log_analytics_saved_search" "this" {
  for_each = { for s in var.saved_searches : s.name => s }

  name                       = each.value.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  category                   = each.value.category
  display_name               = each.value.display_name
  query                      = each.value.query
}

resource "azurerm_log_analytics_workspace_table_custom_log" "this" {
  for_each = toset(var.custom_log_tables)

  name         = each.value
  display_name = each.value
  workspace_id = azurerm_log_analytics_workspace.this.id

  column {
    name = "RawData"
    type = "string"
  }
}
