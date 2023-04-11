resource "env0_project" "" {
  name        = "KMac Demo - Dev"
  description = "Example project"
}

data "env0_project" "default_project" {
  name = ""
}

data "env0_ssh_key" "my_key" {
  name = "Secret Key"
}

resource "env0_template" "kmac-shag-vpc" {
  name        = "KMac SHAG - VPC"
  description = "SHAG"
  repository  = "https://github.com/env0/acme-demo/"
  path        = "kmac-workflow/shag/vpc"
    revision = "main"

  github_installation_id = var.github_installation_id
}

resource "env0_template" "kmac-shag-eks" {
  name        = "KMac SHAG - EKS"
  description = "SHAG"
  repository  = "https://github.com/env0/acme-demo/"
  path        = "kmac-workflow/shag/eks"
    revision = "main"
  github_installation_id = var.github_installation_id
}

resource "env0_template" "kmac-shag-efs" {
  name        = "KMac SHAG - EFS"
  description = "SHAG"
  repository  = "https://github.com/env0/acme-demo/"
  path        = "kmac-workflow/shag/efs"
    revision = "main"
  github_installation_id = var.github_installation_id
}

resource "env0_template" "kmac-shag-csidriver" {
  name        = "KMac SHAG - CSI Driver"
  description = "SHAG"
  repository  = "https://github.com/env0/acme-demo/"
  path        = "kmac-workflow/shag/csi-driver"
    revision = "main"
  github_installation_id = var.github_installation_id
}

resource "env0_template_project_assignment" "assignment" {
  template_id = env0_template.example.id
  project_id  = data.env0_project.default_project.id
}
