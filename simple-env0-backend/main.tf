terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

  backend "remote" {
    hostname     = "backend.api.env0.com"
    organization = "bde19c6d-d0dc-4b11-a951-8f43fe49db92.575b5fb1-4fe9-4b7b-8a64-0c997abaf351"

    workspaces {
      name = "supersimple-worfklow-backend-0414"
    }
  }
}

variable "refresh_date" {
  type    = string
  default = "00/00/0000"
}

resource "random_string" "random" {
  keepers = {
    refresh_date = var.refresh_date
  }
  length  = 20
  upper   = false
  special = false
}

output "random_string" {
  value = random_string.random.result
}