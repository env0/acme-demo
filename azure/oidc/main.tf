# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_oidc

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.7.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  # features {}

  #subscription_id = "00000000-0000-0000-0000-000000000000"  #ARM_SUBSCRIPTION_ID
  #client_id       = "00000000-0000-0000-0000-000000000000"  #ARM_CLIENT_ID
  #tenant_id       = "00000000-0000-0000-0000-000000000000"  #ARM_TENANT_ID
  #use_oidc        = true  #ARM_USE_OIDC
  #oidc_token      = var.oidc_token  #ARM_OIDC_TOKEN
}

data "azurerm_storage_account" "this" {
  name                = "env0acmedemoazstorage"
  resource_group_name = "sales-acme-demo"
}

resource "azurerm_storage_container" "example" {
  name                  = "content"
  storage_account_name  = data.azurerm_storage_account.this.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = data.azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
}