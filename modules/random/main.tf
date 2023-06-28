terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

resource "random_id" "random" {
  keepers = {
    refresh_token = var.refresh_token
  }
  byte_length = var.length
  prefix = var.prefix
}

output "random_id_url" {
  value = random_id.random.b64_url
}

output "random_id" {
  value = random_id.random.b64_std
}