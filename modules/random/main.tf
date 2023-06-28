terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

resource "random_string" "random" {
  keepers = {
    refresh_token = var.refresh_token
  }
  length           = var.length
  numeric          = var.numeric
  special          = var.special
  lower            = var.lower
  upper            = var.upper
  override_special = var.override_special
}

