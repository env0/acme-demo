terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.1.0"
    }
  }
}

provider "random" {
  # Configuration options
}

# resource "local_file" "randomstring" {
#     content     = random_string.random.result
#     filename = "/tmp/49f45071-9ea0-41fb-a36b-768f703a79c9/randomstring.txt"
# }

variable "refresh_date" {
  type = string
  default = "00/00/0000"
}

resource "random_string" "random" {
  keepers = {
      refresh_date = var.refresh_date
  }
  length           = 5
  upper            = true
  special          = false
}

output "random_string" {
    value = random_string.random.result
}

output "environment_variables" {
  value = fileexists("env0.system-env-vars.json") ? jsondecode(file("env0.system-env-vars.json")) : jsondecode ("{\"result\"}:{\"env0.system-env-vars.json not found\"}")
}