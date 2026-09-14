module "rg" {
  source   = "../../modules/resource-group"
  name     = var.resource_group_name
  location = var.location_primary
}

module "network_linux" {
  source              = "../../modules/networking"
  name_prefix         = "uat-linux"
  location            = var.location_primary
  resource_group_name = module.rg.name
  security_rules = [
    { name = "SSH", priority = 300, protocol = "Tcp", destination_port_range = "22" }
  ]
}

module "network_windows" {
  source              = "../../modules/networking"
  name_prefix         = "uat-win"
  location            = var.location_secondary
  resource_group_name = module.rg.name
  security_rules = [
    { name = "RDP", priority = 300, protocol = "Tcp", destination_port_range = "3389" }
  ]
}

module "vm_linux" {
  source               = "../../modules/virtual-machine"
  os_type              = "linux"
  name                 = "uat-linux"
  location             = var.location_primary
  resource_group_name  = module.rg.name
  network_interface_id = module.network_linux.network_interface_id
  ssh_public_key       = var.linux_ssh_public_key
  image_publisher      = "canonical"
  image_offer          = "ubuntu-24_04-lts"
  image_sku            = "server"
  # Consider a smaller vm_size for UAT, e.g.:
  # vm_size = "Standard_B2s"
}

module "vm_windows" {
  source               = "../../modules/virtual-machine"
  os_type              = "windows"
  name                 = "uat-win"
  location             = var.location_secondary
  resource_group_name  = module.rg.name
  network_interface_id = module.network_windows.network_interface_id
  admin_password       = var.windows_admin_password
  image_publisher      = "microsoftwindowsdesktop"
  image_offer          = "windows-11"
  image_sku            = "win11-24h2-entn-ltsc"
}

module "data_factory" {
  source              = "../../modules/data-factory"
  name                = "uat-datafactory"
  location            = var.location_primary
  resource_group_name = module.rg.name
}

module "key_vault" {
  source              = "../../modules/key-vault"
  name                = "uat-keyvault"
  location            = var.location_primary
  resource_group_name = module.rg.name
  tenant_id           = var.tenant_id
}

module "log_analytics" {
  source              = "../../modules/log-analytics"
  name                = "uat-loganalytics"
  location            = var.location_primary
  resource_group_name = module.rg.name
  saved_searches      = []   # copy the same list used in dev if you want parity
  custom_log_tables   = []
}

module "sql_server" {
  source                         = "../../modules/sql-server"
  name                           = "uat-mssql"
  location                       = "eastasia"
  resource_group_name            = module.rg.name
  administrator_login            = "uatsqladmin"
  aad_admin_login                = var.sql_aad_admin_login
  aad_admin_object_id            = var.sql_aad_admin_object_id
  public_network_access_enabled  = false
}

module "storage" {
  source              = "../../modules/storage-account"
  name                = "uatstorageacct"
  location            = var.location_primary
  resource_group_name = module.rg.name
}

module "app_service" {
  source              = "../../modules/app-service"
  name                = "uat-web"
  suffix              = "uat01"
  location            = "westus3"
  resource_group_name = module.rg.name
  sku_name            = "B1"
}
