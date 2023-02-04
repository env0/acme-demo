terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = ">=1.3.5"
    }
  }

  backend "remote" {
    hostname     = "backend.api.env0.com"
    organization = "bde19c6d-d0dc-4b11-a951-8f43fe49db92"
    workspaces {
      name = "day0-environment-2023-02"
    }
  }
}

provider "env0" {
}