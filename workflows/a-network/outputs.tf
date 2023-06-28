output "vpc_id" {
  value = "vpc-${module.vpc.random_string}"
}