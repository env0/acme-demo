output "cluster_name" {
  value = var.compute_name
}

output "instance_id" {
  value = module.compute.id
}

output "network" {
  value = var.vpc_id
}

output "network-test" {
  value = "test-${var.vpc_id}"
}
