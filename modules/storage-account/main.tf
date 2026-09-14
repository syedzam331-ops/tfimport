resource "azurerm_storage_account" "this" {
  name                             = var.name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  account_tier                     = var.account_tier
  account_replication_type         = var.account_replication_type
  allow_nested_items_to_be_public  = false
}

resource "azurerm_storage_account_queue_properties" "this" {
  storage_account_id = azurerm_storage_account.this.id

  hour_metrics {
    version = "1.0"
  }

  minute_metrics {
    version = "1.0"
  }

  logging {
    version = "1.0"
    delete  = false
    read    = false
    write   = false
  }
}
