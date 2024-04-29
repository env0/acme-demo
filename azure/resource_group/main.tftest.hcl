run "test-variable-inputs" {
  variables {
    prefix = "foo"
    location = "eastus"
    last_updated = "2024-04-29"
  }

  assert {
    condition     = azurerm_resource_group.example.location == "eastus"
    error_message = "rg location not us-east"
  }

  assert {
    condition     = azurerm_resource_group.example.name == "foo-sales-rg"
    error_message = "Resource group name is not foo-sales-rg"
  }
}