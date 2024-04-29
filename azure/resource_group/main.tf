terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=3.93.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

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

output "location" {
  value = azurerm_resource_group.example.location
}