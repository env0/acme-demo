variable "length" {
  type = number
  default = 5
}

variable "refresh_token" {
  type    = string
  default = "0"
}

module "infra" {
  source = "../../modules/random"
  length = var.length
  refresh_token = var.refresh_token
}

output "infra_name" {
  value = "infra_base_${module.infra.random_string}"
}