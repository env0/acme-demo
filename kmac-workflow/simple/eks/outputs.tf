output "kubernetes_host" {
  value       = module.eks.cluster_endpoint
  description = "EKS clusters host endpoint"
}

output "cluster_id" {
  value       = module.eks.cluster_id
  description = "EKS cluster id"
}