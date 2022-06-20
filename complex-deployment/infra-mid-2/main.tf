variable "length" {
  type    = number
  default = 5
}

variable "infra_base" {
  type    = string
  default = "0"
}

variable "env_name" {
  type    = string
  default = ""
}

module "infra" {
  source        = "../../modules/random"
  length        = var.length
  refresh_token = var.infra_base
}

output "depends_on" {
  value = var.infra_base
}

output "infra_name" {
  value = "${var.env_name}_${module.infra.random_string}"
}