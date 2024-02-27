resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-sales-rg"
  location = var.location
}

variable "prefix" {
  type = string
  default = "env0"
}

variable "location" {
  type = string
  default = "us-east"
}

output "name" {
  value = azurerm_resource_group.example.name
}