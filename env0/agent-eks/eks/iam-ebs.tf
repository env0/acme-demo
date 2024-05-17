# https://docs.aws.amazon.com/eks/latest/userguide/csi-iam-role.html
# https://docs.aws.amazon.com/eks/latest/userguide/managing-ebs-csi.html

locals {
  oidc_provider  = module.eks.oidc_provider
  aws_account_id = "326535729404"
}

output "oidc_provider" {
  value = local.oidc_provider
}

resource "aws_iam_role" "ebs-csi" {
  name = "AmazonEKS_EBS_CSI_DriverRole"

  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"]
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::${local.aws_account_id}:oidc-provider/${local.oidc_provider}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${local.oidc_provider}:aud" : "sts.amazonaws.com",
            "${local.oidc_provider}:sub" : "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }
      }
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}