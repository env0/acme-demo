Random String Module

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
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_length"></a> [length](#input\_length) | n/a | `number` | `5` | no |
| <a name="input_lower"></a> [lower](#input\_lower) | n/a | `bool` | `true` | no |
| <a name="input_numeric"></a> [numeric](#input\_numeric) | n/a | `bool` | `true` | no |
| <a name="input_override_special"></a> [override\_special](#input\_override\_special) | n/a | `string` | `"-._~"` | no |
| <a name="input_refresh_token"></a> [refresh\_token](#input\_refresh\_token) | n/a | `string` | `"0"` | no |
| <a name="input_special"></a> [special](#input\_special) | n/a | `bool` | `false` | no |
| <a name="input_upper"></a> [upper](#input\_upper) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_result"></a> [result](#output\_result) | n/a |
<!-- END_TF_DOCS -->