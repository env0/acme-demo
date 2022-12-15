terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

module "random" {
  source = "api.env0.com/bde19c6d-d0dc-4b11-a951-8f43fe49db92/random/env0"
  version = "v1.0"
}

