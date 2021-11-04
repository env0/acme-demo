module "eks-cluster" {
  source = "api.env0.com/bde19c6d-d0dc-4b11-a951-8f43fe49db92/eks-cluster/aws"
  version = "0.43.2"
}

module "eks-node-group" {
  source = "api.env0.com/bde19c6d-d0dc-4b11-a951-8f43fe49db92/eks-node-group/aws"
  version = "0.26.2"
}

