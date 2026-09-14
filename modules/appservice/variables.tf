variable "name" {
  type = string
}

variable "suffix" {
  type        = string
  description = "Random/cosmetic suffix aztfexport put on the plan name; can be any short unique string for new envs"
  default     = "01"
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "B1"
}

variable "sampling_percentage" {
  type    = number
  default = 0
}
