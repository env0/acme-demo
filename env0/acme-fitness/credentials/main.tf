terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
      version = "0.0.20"
    }
  }
}

provider "env0" {
}

resource "env0_aws_credentials" "dev" {
  name        = var.name
  arn         = var.arn
  external_id = var.external_id
}

variable name {
    type = string
    description = "Name of Credential"
}
variable arn {
    type = string
    description = "ARN of AWS Assume Role"
}

variable external_id {
    type = string
    sensitive = true
    description = "External ID associated with ARN"
}