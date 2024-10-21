terraform {
  required_version = "= 1.8.3"

  cloud {
    hostname     = "backend.api.env0.com"
    organization = "bde19c6d-d0dc-4b11-a951-8f43fe49db92"

    workspaces {
      name = "simple-terraform-64218540"
    }
  }
}
