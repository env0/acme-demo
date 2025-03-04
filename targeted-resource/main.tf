# main.tf (IAM Roles Module)
provider "aws" {
  region = "us-east-1" # Change to your preferred AWS region
}

resource "aws_iam_role" "roles" {
  for_each = {
    karpenter-node      = "Karpenter Node Role"
    karpenter-controller = "Karpenter Controller Role"
  }

  name               = each.key
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "custom" {
  for_each = {
    karpenter-node      = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    karpenter-controller = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  }

  name   = "${each.key}-policy"
  policy = data.aws_iam_policy_document.inline.json
}

resource "aws_iam_role_policy_attachment" "custom" {
  for_each = {
    karpenter-node      = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    karpenter-controller = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  }

  role       = aws_iam_role.roles[each.key].name
  policy_arn = each.value
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "inline" {
  statement {
    actions   = ["s3:ListBucket", "ec2:DescribeInstances"]
    resources = ["*"]
  }
}

output "role_arn" {
  value = aws_iam_role.roles["karpenter-node"].arn
}