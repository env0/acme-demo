
# modules/iam_roles/main.tf
resource "aws_iam_role" "roles" {
  for_each = var.roles

  name               = "${var.env}-${var.group}-${each.key}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "custom" {
  for_each = var.roles

  name   = "${var.env}-${var.group}-${each.key}-policy"
  policy = data.aws_iam_policy_document.inline.json
}

resource "aws_iam_role_policy_attachment" "custom" {
  for_each = var.roles

  role       = aws_iam_role.roles[each.key].name
  policy_arn = each.value.policy_arn
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

output "arns" {
  description = "The ARN of the created IAM roles"
  value = {
    for role, data in aws_iam_role.roles :
    replace(role, "${var.env}-${var.group}-", "") => data.arn
  }
}

output "env" {
  value = var.env
}

output "group" {
  value = var.group
}
