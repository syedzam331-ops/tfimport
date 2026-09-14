variable "name_prefix" {
  type        = string
  description = "Short prefix used for NIC/NSG/IP naming, e.g. \"rg1\""
}

variable "rg_name" {
  type = string
}

variable "location_primary" {
  type = string
}

variable "location_secondary" {
  type = string
}

variable "linux_vm_name" {
  type = string
}

variable "windows_vm_name" {
  type = string
}

variable "linux_nic_suffix" {
  type    = string
  default = ""
}

variable "windows_nic_suffix" {
  type    = string
  default = ""
}

variable "linux_ssh_public_key" {
  type      = string
  sensitive = true
}

variable "windows_admin_password" {
  type      = string
  sensitive = true
}

variable "datafactory_name" {
  type = string
}

variable "keyvault_name" {
  type        = string
  description = "Must be globally unique across Azure"
}

variable "tenant_id" {
  type = string
}

variable "log_analytics_name" {
  type = string
}

variable "saved_searches" {
  type = list(object({
    name         = string
    category     = string
    display_name = string
    query        = string
  }))
  default = []
}

variable "custom_log_tables" {
  type    = list(string)
  default = []
}

variable "sql_server_name" {
  type        = string
  description = "Must be globally unique across Azure"
}

variable "sql_location" {
  type = string
}

variable "sql_admin_login" {
  type = string
}

variable "sql_aad_admin_login" {
  type = string
}

variable "sql_aad_admin_object_id" {
  type = string
}

variable "storage_account_name" {
  type        = string
  description = "Must be globally unique across Azure, lowercase, <=24 chars"
}

variable "app_service_name" {
  type        = string
  description = "Must be globally unique across Azure"
}

variable "app_service_suffix" {
  type    = string
  default = "01"
}

variable "app_service_location" {
  type = string
}

variable "app_service_sku" {
  type    = string
  default = "B1"
}
