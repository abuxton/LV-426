variable "admin_username" {
  type        = string
  description = "Administrator user name for virtual machine"
}

variable "admin_password" {
  type        = string
  description = "Password must meet Azure complexity requirements"
}
variable "location" {
  type        = string
  description = "location, or Azure region"
  default     = "uksouth"
}
variable "prefix" {
  type        = string
  description = "prefix for reusability and identity"
  default     = "new-lv-426"
}
