module "vpc" {
  source  = "api.env0.com/bde19c6d-d0dc-4b11-a951-8f43fe49db92/random/acme"
  version = "~> 1.0"

  length        = var.length
  refresh_token = var.refresh_token

}
