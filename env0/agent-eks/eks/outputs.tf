output "kubernetes_host" {
  value       = module.eks.kubernetes_host
  description = "EKS cluster host endpoint"
}

output "cluster_id" {
  value       = module.eks.cluster_id
  description = "EKS cluster id"
}