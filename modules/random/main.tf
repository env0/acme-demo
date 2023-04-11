terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

variable "refresh_token" {
  type    = string
  default = "0"
}

variable "length" {
  type    = number
  default = 5
}

resource "random_string" "random" {
  keepers = {
    refresh_token = var.refresh_token
  }
  length  = var.length
  upper   = false
  special = false
}

output "random_string" {
  value = random_string.random.result
}