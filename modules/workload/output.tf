output "resource_group_name" {
  value = module.rg.name
}

output "web_app_hostname" {
  value = module.app_service.default_hostname
}

output "sql_server_fqdn" {
  value = module.sql_server.fqdn
}

output "storage_account_id" {
  value = module.storage.id
}
