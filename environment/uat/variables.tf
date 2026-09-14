variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type    = string
  default = "80a854d4-3a6e-4727-9e74-6322a29873a4"
}

variable "resource_group_name" {
  type    = string
  default = "suri-uat-rg"
}

variable "location_primary" {
  type    = string
  default = "eastus"
}

variable "location_secondary" {
  type    = string
  default = "southindia"
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
