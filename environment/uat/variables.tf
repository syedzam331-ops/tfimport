variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type    = string
  default = "80a854d4-3a6e-4727-9e74-6322a29873a4"
}

variable "workloads" {
  type = map(object({
    name_prefix          = string
    rg_name              = string
    location_primary     = string
    location_secondary   = string
    linux_vm_name        = string
    windows_vm_name      = string
    linux_nic_suffix     = optional(string, "")
    windows_nic_suffix   = optional(string, "")
    datafactory_name     = string
    keyvault_name        = string
    log_analytics_name   = string
    sql_server_name      = string
    sql_location         = string
    sql_admin_login      = string
    storage_account_name = string
    app_service_name     = string
    app_service_suffix   = optional(string, "01")
    app_service_location = string
    app_service_sku      = optional(string, "B1")
  }))
}

variable "linux_ssh_public_key" {
  type      = string
  sensitive = true
}

variable "windows_admin_password" {
  type      = string
  sensitive = true
}

variable "sql_aad_admin_login" {
  type = string
}

variable "sql_aad_admin_object_id" {
  type = string
}
