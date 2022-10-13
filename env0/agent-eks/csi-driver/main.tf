# OIDC and CSI Driver

data "aws_efs_file_system" "this" {
  tags = {
    Name = "${var.cluster_name}-state-efs"
  }
}

module "csi_driver" {
  source = "git@github.com:env0/k8s-modules.git//aws/csi-driver"

  efs_id         = data.aws_efs_file_system.this.file_system_id
  reclaim_policy = var.reclaim_policy
  cluster_name   = var.cluster_name
}