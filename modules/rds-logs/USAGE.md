<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudwatch_logs"></a> [cloudwatch\_logs](#module\_cloudwatch\_logs) | ../cloudwatch-logs | n/a |
| <a name="module_rds_lambda_transform"></a> [rds\_lambda\_transform](#module\_rds\_lambda\_transform) | terraform-aws-modules/lambda/aws | ~> 4.2 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_engine"></a> [db\_engine](#input\_db\_engine) | Engine type on your RDS database | `string` | n/a | yes |
| <a name="input_db_log_types"></a> [db\_log\_types](#input\_db\_log\_types) | n/a | `list(string)` | n/a | yes |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Name of your RDS database. | `string` | n/a | yes |
| <a name="input_honeycomb_api_host"></a> [honeycomb\_api\_host](#input\_honeycomb\_api\_host) | If you use a Secure Tenancy or other proxy, put its schema://host[:port] here. | `string` | `"https://api.honeycomb.io"` | no |
| <a name="input_honeycomb_api_key"></a> [honeycomb\_api\_key](#input\_honeycomb\_api\_key) | Your Honeycomb team's API key. | `string` | n/a | yes |
| <a name="input_honeycomb_dataset_name"></a> [honeycomb\_dataset\_name](#input\_honeycomb\_dataset\_name) | Your Honeycomb dataset name. | `string` | n/a | yes |
| <a name="input_http_buffering_interval"></a> [http\_buffering\_interval](#input\_http\_buffering\_interval) | Kinesis Firehose http buffer interval, in seconds. | `number` | `60` | no |
| <a name="input_http_buffering_size"></a> [http\_buffering\_size](#input\_http\_buffering\_size) | Kinesis Firehose http buffer size, in MiB. | `number` | `15` | no |
| <a name="input_lambda_function_memory"></a> [lambda\_function\_memory](#input\_lambda\_function\_memory) | Memory allocated to the Lambda function in MB. Must be between 128 and 10,240 (10GB), in 64MB increments. | `number` | `192` | no |
| <a name="input_lambda_function_timeout"></a> [lambda\_function\_timeout](#input\_lambda\_function\_timeout) | Timeout in seconds for lambda function. | `number` | `600` | no |
| <a name="input_lambda_package_bucket"></a> [lambda\_package\_bucket](#input\_lambda\_package\_bucket) | Internal. Override S3 bucket where lambda function zip is located. | `string` | `""` | no |
| <a name="input_lambda_package_key"></a> [lambda\_package\_key](#input\_lambda\_package\_key) | Internal. Override S3 key where lambda function zip is located. | `string` | `""` | no |
| <a name="input_log_subscription_filter_pattern"></a> [log\_subscription\_filter\_pattern](#input\_log\_subscription\_filter\_pattern) | A valid CloudWatch Logs filter pattern for subscribing to a filtered stream of log events. Defaults to empty string to match everything. For more information, see the Amazon CloudWatch Logs User Guide. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | A name for this CloudWatch Kinesis Firehose Stream. | `string` | n/a | yes |
| <a name="input_s3_backup_mode"></a> [s3\_backup\_mode](#input\_s3\_backup\_mode) | Should we only backup to S3 data that failed delivery, or all data? | `string` | `"FailedDataOnly"` | no |
| <a name="input_s3_buffer_interval"></a> [s3\_buffer\_interval](#input\_s3\_buffer\_interval) | In seconds. See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html | `number` | `400` | no |
| <a name="input_s3_buffer_size"></a> [s3\_buffer\_size](#input\_s3\_buffer\_size) | In MiB. See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html | `number` | `10` | no |
| <a name="input_s3_compression_format"></a> [s3\_compression\_format](#input\_s3\_compression\_format) | May be GZIP, Snappy, Zip, or Hadoop-Compatiable Snappy. See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html | `string` | `"GZIP"` | no |
| <a name="input_s3_failure_bucket_arn"></a> [s3\_failure\_bucket\_arn](#input\_s3\_failure\_bucket\_arn) | ARN of the S3 bucket that will store any logs that failed to be sent to Honeycomb. | `string` | n/a | yes |
| <a name="input_s3_force_destroy"></a> [s3\_force\_destroy](#input\_s3\_force\_destroy) | By default, AWS will decline to delete S3 buckets that are not empty:<br> `BucketNotEmpty: The bucket you tried to delete is not empty`.  These buckets<br> are used for backup if delivery or processing fail.<br> #<br> To allow this module's resources to be removed, we've set force\_destroy =<br> true, allowing non-empty buckets to be deleted. If you want to block this and<br> preserve those failed deliveries, you can set this value to false, though that<br> will leave terraform unable to cleanly destroy the module. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources created by this module. | `map(string)` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->