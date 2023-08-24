terraform {
  backend "remote" {
    hostname = "backend.api.env0.com"
    organization = "bde19c6d-d0dc-4b11-a951-8f43fe49db92.6932f811-a7d0-4c8e-923c-3f2f285dacc3"
    workspaces {
      name = "remote-backend-demo0824"
    }
  }
}