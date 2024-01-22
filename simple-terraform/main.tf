terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

variable "refresh_date" {
  type = string
  default = "00/00/0000"
}

resource "random_string" "random" {
  keepers = {
      refresh_date = var.refresh_date
  }
  length           = 7
  upper            = true
  special          = false
}

output "random_string" {
    value = random_string.random.result
}
