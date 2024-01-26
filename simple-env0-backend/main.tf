terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }

  cloud {
    hostname = "backend.api.env0.com"
    organization = "bde19c6d-d0dc-4b11-a951-8f43fe49db92.edba559d-ae7f-467d-a2f8-1b5a54709ead"
    workspaces {
      name = "test-remote-backend-20240102"
    }
  }
}

module "random" {
  source = "api.env0.com/bde19c6d-d0dc-4b11-a951-8f43fe49db92/random/env0"
  version = "~>1.0.0"
}

