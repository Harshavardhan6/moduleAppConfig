variable "resource_group_name" {
  description = "The name of the resource group where the App Configuration service will be created."
  type        = string
}

variable "environment" {
  type = string
}

variable "location" {
  description = "The Azure location where the App Configuration service should be deployed."
  type        = string
  default     = "West Europe"
}

variable "app_config_name" {
  description = "The name of the App Configuration service."
  type        = string
}

variable "sku" {
  description = "The SKU of the App Configuration service."
  type        = string
  default     = "free"
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "principal_id" {
  type        = string
  description = "The ID of the principal (user, group, or service principal) to be granted access to the App Configuration"
}

variable "configuration_keys" {
  type = list(object({
    key          = string
    value        = string
    content_type = string
    label        = string
  }))
  description = "A list of key-value pairs to be added to the App Configuration"
  default     = []
}
