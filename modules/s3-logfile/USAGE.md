<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_log_bucket"></a> [log\_bucket](#module\_log\_bucket) | terraform-aws-modules/s3-bucket/aws//modules/notification | ~> 3.0 |
| <a name="module_s3_processor"></a> [s3\_processor](#module\_s3\_processor) | terraform-aws-modules/lambda/aws | ~> 4.2 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_arn.kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |
| [aws_arn.s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |
| [aws_iam_policy_document.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment this code is running in. If set, will be added as 'env' to each event. | `string` | `""` | no |
| <a name="input_filter_fields"></a> [filter\_fields](#input\_filter\_fields) | Strings to specify which field names to remove from events. | `list(string)` | `[]` | no |
| <a name="input_honeycomb_api_host"></a> [honeycomb\_api\_host](#input\_honeycomb\_api\_host) | Internal. Alternative Honeycomb API host. | `string` | `"https://api.honeycomb.io"` | no |
| <a name="input_honeycomb_api_key"></a> [honeycomb\_api\_key](#input\_honeycomb\_api\_key) | Honeycomb API Key | `string` | n/a | yes |
| <a name="input_honeycomb_dataset"></a> [honeycomb\_dataset](#input\_honeycomb\_dataset) | Honeycomb Dataset where events will be sent. | `string` | `"lb-access-logs"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | KMS Key ARN of key used to encript var.honeycomb\_api\_key. | `string` | `""` | no |
| <a name="input_lambda_function_memory"></a> [lambda\_function\_memory](#input\_lambda\_function\_memory) | Memory allocated to the Lambda function in MB. Must be between 128 and 10,240 (10GB), in 64MB increments. | `number` | `192` | no |
| <a name="input_lambda_function_timeout"></a> [lambda\_function\_timeout](#input\_lambda\_function\_timeout) | Timeout in seconds for lambda function. | `number` | `600` | no |
| <a name="input_lambda_package_bucket"></a> [lambda\_package\_bucket](#input\_lambda\_package\_bucket) | Internal. Override S3 bucket where lambda function zip is located. | `string` | `""` | no |
| <a name="input_lambda_package_key"></a> [lambda\_package\_key](#input\_lambda\_package\_key) | Internal. Override S3 key where lambda function zip is located. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | A name for this integration.<br>  Used for the lambda name, so should be unique within your AWS account. | `string` | n/a | yes |
| <a name="input_parser_type"></a> [parser\_type](#input\_parser\_type) | The type of logfile to parse. | `string` | n/a | yes |
| <a name="input_rename_fields"></a> [rename\_fields](#input\_rename\_fields) | Map of fields to rename, old -> new. | `map(string)` | `{}` | no |
| <a name="input_s3_bucket_arn"></a> [s3\_bucket\_arn](#input\_s3\_bucket\_arn) | The full ARN of the bucket storing load balancer access logs. | `string` | n/a | yes |
| <a name="input_s3_filter_prefix"></a> [s3\_filter\_prefix](#input\_s3\_filter\_prefix) | Prefix within logs bucket to restrict processing. | `string` | `""` | no |
| <a name="input_s3_filter_suffix"></a> [s3\_filter\_suffix](#input\_s3\_filter\_suffix) | Suffix of files that should be processed. | `string` | `".gz"` | no |
| <a name="input_sample_rate"></a> [sample\_rate](#input\_sample\_rate) | Sample rate. See https://honeycomb.io/docs/guides/sampling/. | `number` | `1` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources created by this module. | `map(string)` | `null` | no |
| <a name="vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#vpc\_security\_group\_ids) | List of security group ids when Lambda Function should run in the VPC. | `list(string)` | `[]` | no |
| <a name="vpc_subnet_ids"></a> [vpc\_subnet\_ids](#vpc\_subnet\_ids) | List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets. | `list(string)` | `[]` | no |


## Outputs

No outputs.
<!-- END_TF_DOCS -->
