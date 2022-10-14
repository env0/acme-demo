data "aws_vpc" "this" {
  tags = {
    Name = "vpc-${var.cluster_name}"
  }
}

resource "null_resource" "agent_values" {
  count = var.localrun ? 1 : 0

  provisioner "local-exec" {
    command = "./download-values.sh"
  }
}

resource "helm_release" "agent" {
  name             = "env0-agent"
  namespace        = "env0-agent"
  chart            = "env0-agent"
  create_namespace = true
  repository       = "https://env0.github.io/self-hosted"
  timeout          = 600
  values = [
    yamlencode(file(values.yaml))
  ]

  set {
    name  = "infracostApiKeyEncoded"
    value = var.infracostApiKeyEncoded
  }

  depends_on = [
    null_resource.agent_values
  ]
}