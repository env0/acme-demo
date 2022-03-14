variable "length" {
  type    = number
  default = 5
}

variable "infra_mid" {
  type    = string
  default = "0"
}

module "infra" {
  source        = "../../modules/random"
  length        = var.length
  refresh_token = var.depends_on
}

output "depends_on" {
  value = var.infra_mid
}

output "infra_name" {
  value = "infra_top_${module.infra.random_string}"
}