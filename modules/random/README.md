Random ID Module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_id.random](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_byte_length"></a> [byte\_length](#input\_byte\_length) | n/a | `number` | `2` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `""` | no |
| <a name="input_refresh_token"></a> [refresh\_token](#input\_refresh\_token) | n/a | `string` | `"0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_random_id"></a> [random\_id](#output\_random\_id) | n/a |
| <a name="output_random_id_url"></a> [random\_id\_url](#output\_random\_id\_url) | n/a |
<!-- END_TF_DOCS -->