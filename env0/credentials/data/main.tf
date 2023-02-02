terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

# Configure the env0 provider

provider "env0" {
}

data "env0_cloud_credentials" "credentials" {
  credential_type = "GCP_SERVICE_ACCOUNT_FOR_DEPLOYMENT"
}

data "env0_gcp_credentials" "credentials" {
  for_each = toset(data.env0_cloud_credentials.credentials.names)
  name     = each.value
}

output "credentials" {
  value = data.env0_cloud_credentials.credentials
}

output "credentials_id" {
  value = data.env0_gcp_credentials.credentials["test"].id
}