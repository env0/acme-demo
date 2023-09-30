terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    env0 = {
      source  = "env0/env0"
      version = "~> 1.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"

  assume_role {
    role_arn = "arn:aws:iam::326535729404:role/acme-secret-reader"
  }
}

data "aws_secretsmanager_secret" "env0_api_key" {
  arn = "arn:aws:secretsmanager:us-west-2:326535729404:secret:dev/env0_api-jtwkmx"
}

data "aws_secretsmanager_secret_version" "env0_api_key" {
  secret_id = data.aws_secretsmanager_secret.env0_api_key.id
}

provider "env0" {
  #api_key    = var.env0_api_key      # or $ENV0_API_KEY
  #api_secret = var.env0_api_secret   # or $ENV0_API_SECRET
  # this is required if you're using a personal API key with access to mutiple orgs
  organization_id = "bde19c6d-d0dc-4b11-a951-8f43fe49db92"

  ## example managing env0 API key through a secrets manager
  # alternatively reference your secrets manager
  api_key    = jsondecode(data.aws_secretsmanager_secret_version.env0_api_key.secret_string)["api_key"]
  api_secret = jsondecode(data.aws_secretsmanager_secret_version.env0_api_key.secret_string)["api_secret"]
}
