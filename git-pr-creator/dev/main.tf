module "random" {
  source = "../../moduloes/random"
  refresh_token = var.instance_type
}

variable "instance_type" {
  default = "t2.micro"
  type = string
}

output "instance_type" {
  value = var.instance_type
}