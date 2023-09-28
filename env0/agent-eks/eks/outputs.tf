output "cluster_name" {
  value       = module.eks.cluster_name
  description = "EKS Cluster Name"
}

output "cluster_id" {
  value       = module.eks.cluster_id
  description = "EKS cluster id"
}