<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kfh"></a> [kfh](#module\_kfh) | ../kinesis-firehose-honeycomb | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_subscription_filter.filters](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_subscription_filter) | resource |
| [aws_cloudwatch_log_subscription_filter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_subscription_filter) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.cwl_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_destinations"></a> [additional\_destinations](#input\_additional\_destinations) | Additional sinks can be configured here. | <pre>list(object({<br>    honeycomb_dataset_name = string,<br>    honeycomb_api_key      = string,<br>    honeycomb_api_host     = string,<br>  }))</pre> | `[]` | no |
| <a name="input_cloudwatch_log_groups"></a> [cloudwatch\_log\_groups](#input\_cloudwatch\_log\_groups) | CloudWatch Log Group names to stream to Honeycomb | `list(string)` | n/a | yes |
| <a name="input_enable_lambda_transform"></a> [enable\_lambda\_transform](#input\_enable\_lambda\_transform) | Enable a Lambda transform on the Kinesis Firehose to preprocess and structure the logs | `bool` | `false` | no |
| <a name="input_honeycomb_api_host"></a> [honeycomb\_api\_host](#input\_honeycomb\_api\_host) | If you use a Secure Tenancy or other proxy, put its schema://host[:port] here. | `string` | `"https://api.honeycomb.io"` | no |
| <a name="input_honeycomb_api_key"></a> [honeycomb\_api\_key](#input\_honeycomb\_api\_key) | Your Honeycomb team's API key. | `string` | n/a | yes |
| <a name="input_honeycomb_dataset_name"></a> [honeycomb\_dataset\_name](#input\_honeycomb\_dataset\_name) | Your Honeycomb dataset name. | `string` | n/a | yes |
| <a name="input_http_buffering_interval"></a> [http\_buffering\_interval](#input\_http\_buffering\_interval) | Kinesis Firehose http buffer interval, in seconds. | `number` | `60` | no |
| <a name="input_http_buffering_size"></a> [http\_buffering\_size](#input\_http\_buffering\_size) | Kinesis Firehose http buffer size, in MiB. | `number` | `15` | no |
| <a name="input_lambda_transform_arn"></a> [lambda\_transform\_arn](#input\_lambda\_transform\_arn) | If enable\_lambda\_transform is set to true, specify a valid arn | `string` | `""` | no |
| <a name="input_log_subscription_filter_pattern"></a> [log\_subscription\_filter\_pattern](#input\_log\_subscription\_filter\_pattern) | A valid CloudWatch Logs filter pattern for subscribing to a filtered stream of log events. Defaults to empty string to match everything. For more information, see the Amazon CloudWatch Logs User Guide. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | A name for this CloudWatch Kinesis Firehose Stream. | `string` | `"honeycomb-cloudwatch-logs"` | no |
| <a name="input_s3_backup_mode"></a> [s3\_backup\_mode](#input\_s3\_backup\_mode) | Should we only backup to S3 data that failed delivery, or all data? | `string` | `"FailedDataOnly"` | no |
| <a name="input_s3_buffer_interval"></a> [s3\_buffer\_interval](#input\_s3\_buffer\_interval) | In seconds. See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html | `number` | `400` | no |
| <a name="input_s3_buffer_size"></a> [s3\_buffer\_size](#input\_s3\_buffer\_size) | In MiB. See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html | `number` | `10` | no |
| <a name="input_s3_compression_format"></a> [s3\_compression\_format](#input\_s3\_compression\_format) | May be GZIP, Snappy, Zip, or Hadoop-Compatiable Snappy. See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html | `string` | `"GZIP"` | no |
| <a name="input_s3_failure_bucket_arn"></a> [s3\_failure\_bucket\_arn](#input\_s3\_failure\_bucket\_arn) | ARN of the S3 bucket that will store any logs that failed to be sent to Honeycomb. | `string` | n/a | yes |
| <a name="input_s3_force_destroy"></a> [s3\_force\_destroy](#input\_s3\_force\_destroy) | By default, AWS will decline to delete S3 buckets that are not empty:<br> `BucketNotEmpty: The bucket you tried to delete is not empty`.  These buckets<br> are used for backup if delivery or processing fail.<br> #<br> To allow this module's resources to be removed, we've set force\_destroy =<br> true, allowing non-empty buckets to be deleted. If you want to block this and<br> preserve those failed deliveries, you can set this value to false, though that<br> will leave terraform unable to cleanly destroy the module. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to resources created by this module. | `map(string)` | `{}` | no |
| <a name="input_use_order_independent_filter_resource_naming"></a> [use\_order\_independent\_filter\_resource\_naming](#input\_use\_order\_independent\_filter\_resource\_naming) | Use order-independent naming for log group subscription filter resources. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_log_subscription_filters"></a> [cloudwatch\_log\_subscription\_filters](#output\_cloudwatch\_log\_subscription\_filters) | n/a |
<!-- END_TF_DOCS -->