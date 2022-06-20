variable "length" {
  type    = number
  default = 5
}

module "infra" {
  source        = "../../modules/random"
  length        = var.length
  refresh_token = var.infra_mid
}

output "infra_name" {
  value = "infra_top_${module.infra.random_string}"
}