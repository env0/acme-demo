terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = "0.0.20"
    }
  }
}

module "template" {
  source  = "api.env0.com/c89e9161-8350-44a5-81cf-9eb26605e195/template/env0"
  version = "~> 0.0.6"
  #   source = "git@github.com:env0/terraform-env0-template.git"

  templates = var.templates
}

variable "templates" {
  type = map(
    object({
      name                   = string
      description            = string
      repository             = string
      path                   = string
      revision               = string
      terraform_version      = string
      ssh_keys               = list(map(string))
      github_installation_id = number
      projects               = list(string)
    })
  )
  description = "define a set of templates assigned to projects"
}