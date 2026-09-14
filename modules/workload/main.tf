module "rg" {
  source   = "../resource-group"
  name     = var.rg_name
  location = var.location_primary
}

module "network_linux" {
  source              = "../networking"
  name_prefix         = "${var.name_prefix}-linux"
  nic_suffix          = var.linux_nic_suffix
  location            = var.location_primary
  resource_group_name = module.rg.name
  security_rules = [
    { name = "SSH", priority = 300, protocol = "Tcp", destination_port_range = "22" }
  ]
}

module "network_windows" {
  source              = "../networking"
  name_prefix         = "${var.name_prefix}-win"
  nic_suffix          = var.windows_nic_suffix
  location            = var.location_secondary
  resource_group_name = module.rg.name
  security_rules = [
    { name = "RDP", priority = 300, protocol = "Tcp", destination_port_range = "3389" }
  ]
}

# Commented out VM modules because modules/virtual-machine directory does not exist yet
# module "vm_linux" {
#   source               = "../virtual-machine"
#   os_type              = "linux"
#   name                 = var.linux_vm_name
#   location             = var.location_primary
#   resource_group_name  = module.rg.name
#   network_interface_id = module.network_linux.network_interface_id
#   ssh_public_key       = var.linux_ssh_public_key
#   image_publisher      = "canonical"
#   image_offer          = "ubuntu-24_04-lts"
#   image_sku            = "server"
# }

# module "vm_windows" {
#   source               = "../virtual-machine"
#   os_type              = "windows"
#   name                 = var.windows_vm_name
#   location             = var.location_secondary
#   resource_group_name  = module.rg.name
#   network_interface_id = module.network_windows.network_interface_id
#   admin_password       = var.windows_admin_password
#   image_publisher      = "microsoftwindowsdesktop"
#   image_offer          = "windows-11"
#   image_sku            = "win11-24h2-entn-ltsc"
# }

module "data_factory" {
  source              = "../datafactory"
  name                = var.datafactory_name
  location            = var.location_primary
  resource_group_name = module.rg.name
}

module "key_vault" {
  source              = "../key-vault"
  name                = var.keyvault_name
  location            = var.location_primary
  resource_group_name = module.rg.name
  tenant_id           = var.tenant_id
}

module "log_analytics" {
  source              = "../log-analytics"
  name                = var.log_analytics_name
  location            = var.location_primary
  resource_group_name = module.rg.name
  saved_searches      = var.saved_searches
  custom_log_tables   = var.custom_log_tables
}

module "sql_server" {
  source                        = "../sql-server"
  name                          = var.sql_server_name
  location                      = var.sql_location
  resource_group_name           = module.rg.name
  administrator_login           = var.sql_admin_login
  aad_admin_login               = var.sql_aad_admin_login
  aad_admin_object_id           = var.sql_aad_admin_object_id
  public_network_access_enabled = false
}

module "storage" {
  source              = "../storage-account"
  name                = var.storage_account_name
  location            = var.location_primary
  resource_group_name = module.rg.name
}

module "app_service" {
  source              = "../appservice"
  name                = var.app_service_name
  suffix              = var.app_service_suffix
  location            = var.app_service_location
  resource_group_name = module.rg.name
  sku_name            = var.app_service_sku
}
