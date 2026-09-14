variable "name_prefix" {
  type        = string
  description = "Prefix for NSG/IP/NIC names, e.g. import-test-linux"
}

variable "suffix" {
  type        = string
  description = "Short suffix for vnet/subnet names, e.g. '1'"
  default     = "1"
}

variable "nic_suffix" {
  type        = string
  description = "Numeric suffix aztfexport appended to the NIC name (cosmetic; safe to randomize on new envs)"
  default     = ""
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "address_space" {
  type    = list(string)
  default = ["172.16.0.0/16"]
}

variable "subnet_prefixes" {
  type    = list(string)
  default = ["172.16.0.0/24"]
}

variable "security_rules" {
  description = "List of inbound NSG rules"
  type = list(object({
    name                   = string
    priority               = number
    protocol               = string
    destination_port_range = string
  }))
  default = []
}
