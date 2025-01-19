variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

# variable "rgname" {
#   type        = string
#   description = "resource group name"
# }

# variable "storage_account_name" {
#   type        = string
#   description = "resource group name"
#   default = "terraform-backend"
# }

variable "location" {
  type    = string
  default = "canadacentral"
}

# variable "service_principal_name" {
#   type = string
# }

# variable "keyvault_name" {
#   type = string
# }