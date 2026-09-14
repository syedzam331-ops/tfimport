variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "sql_version" {
  type    = string
  default = "12.0"
}

variable "administrator_login" {
  type = string
}

variable "public_network_access_enabled" {
  type    = bool
  default = false
}

variable "aad_admin_login" {
  type = string
}

variable "aad_admin_object_id" {
  type = string
}

variable "auditing_enabled" {
  type    = bool
  default = false
}

variable "security_alert_state" {
  type    = string
  default = "Disabled"
}

variable "enable_vulnerability_assessment" {
  type    = bool
  default = false
}

variable "vulnerability_assessment_storage_path" {
  type    = string
  default = ""
}
