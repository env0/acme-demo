provider "aws" {
  region = var.aws_region
}

module "roles" {
  source = "./modules/iam_roles"
}

module "roles2" {
  source = "./modules/iam_roles2"
}


output "role_arns" {
  description = "The ARN of the created IAM roles"
  value = {
    for role, data in module.roles.arns :
    replace(role, "${module.roles.env}-${module.roles.group}-", "") => data
  }
}