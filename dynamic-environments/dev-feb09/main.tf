terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

variable "refresh_date" {
  type    = string
  default = "00/00/0000"
}

module "random" {
  source  = "api.env0.com/bde19c6d-d0dc-4b11-a951-8f43fe49db92/random/acme"
  version = "1.1.0"

  refresh_date = var.refresh_date
}

output "random_string" {
  value = module.random.random_string
}