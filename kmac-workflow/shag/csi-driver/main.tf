data "aws_efs_file_system" "kmac-csi" {
  tags = {
    Name = "kmac-shag2-state-efs"
  }
}

module "csi-driver" {
  source       = "git@github.com:env0/k8s-modules.git//aws/csi-driver"
  cluster_name = "kmac-shag2"
  efs_id       = data.aws_efs_file_system.kmac-csi.file_system_id
}

