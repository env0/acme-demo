terraform {
  required_providers {
    env0 = {
      source  = "env0/env0"
      version = "0.0.20"
    }
  }
}

provider "env0" {
}

module "template" {
  source = "api.env0.com/c89e9161-8350-44a5-81cf-9eb26605e195/template/env0"
  version = "~> 0.0.1"

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
      ssh_keys               = list(string)
      github_installation_id = number
      projects               = list(string)
    })
  )
  description = "define a set of templates assigned to projects"
}