data "aws_vpc" "this" {
  tags = {
    Name = "vpc-${var.cluster_name}"
  }
}

resource "helm_release" "agent" {
  name             = "env0-agent"
  namespace        = "env0-agent"
  chart            = "env0-agent"
  create_namespace = true
  repository       = "https://env0.github.io/self-hosted"
  timeout          = 600
  reuse_values     = var.reuse_values
  values = [
    file("values.yaml")
  ]

  set_sensitive {
    name  = "infracostApiKeyEncoded"
    value = var.infracostApiKeyEncoded
  }

  set {
    name  = "jobHistoryLimitFailure"
    value = var.jobHistoryLimitFailure
  }

  set {
    name  = "jobHistoryLimitSuccess"
    value = var.jobHistoryLimitSuccess
  }
}
