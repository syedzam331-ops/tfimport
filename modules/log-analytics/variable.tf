variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "sku" {
  type    = string
  default = "PerGB2018"
}

variable "retention_in_days" {
  type    = number
  default = 30
}

variable "saved_searches" {
  description = "List of saved search definitions"
  type = list(object({
    name          = string
    category      = string
    display_name  = string
    query         = string
  }))
  default = []
}

variable "custom_log_tables" {
  description = <<-EOT
    Names of ACTUAL custom log tables only (tables your own agents/apps
    ingest RawData into). The original aztfexport output listed ~700
    tables here, but the vast majority (AzureActivity, Syslog, Heartbeat,
    SigninLogs, ContainerLogV2, AppTraces, etc.) are Azure built-in
    tables that already exist on any workspace with the right solution
    or diagnostic setting enabled — they are not created by this
    resource and importing them as such will conflict with Azure-managed
    state. Prune the list down to tables you actually authored before
    using this variable in dev/uat/prod.
  EOT
  type    = list(string)
  default = []
}
