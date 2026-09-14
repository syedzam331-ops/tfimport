module "workload" {
  source   = "../../modules/workload"
  for_each = var.workloads

  name_prefix             = each.value.name_prefix
  rg_name                 = each.value.rg_name
  location_primary        = each.value.location_primary
  location_secondary      = each.value.location_secondary
  linux_vm_name           = each.value.linux_vm_name
  windows_vm_name         = each.value.windows_vm_name
  linux_nic_suffix        = each.value.linux_nic_suffix
  windows_nic_suffix      = each.value.windows_nic_suffix
  linux_ssh_public_key    = var.linux_ssh_public_key
  windows_admin_password  = var.windows_admin_password
  datafactory_name        = each.value.datafactory_name
  keyvault_name           = each.value.keyvault_name
  tenant_id               = var.tenant_id
  log_analytics_name      = each.value.log_analytics_name
  sql_server_name         = each.value.sql_server_name
  sql_location            = each.value.sql_location
  sql_admin_login         = each.value.sql_admin_login
  sql_aad_admin_login     = var.sql_aad_admin_login
  sql_aad_admin_object_id = var.sql_aad_admin_object_id
  storage_account_name    = each.value.storage_account_name
  app_service_name        = each.value.app_service_name
  app_service_suffix      = each.value.app_service_suffix
  app_service_location    = each.value.app_service_location
  app_service_sku         = each.value.app_service_sku
}

