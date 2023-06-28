output "cluster_name" {
  value = var.compute_name
}

output "instance_id" {
  value = module.compute.random_id
}

output "network" {
  value = var.vpc_id
}