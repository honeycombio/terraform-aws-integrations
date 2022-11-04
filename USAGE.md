<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.9.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudwatch_logs"></a> [cloudwatch\_logs](#module\_cloudwatch\_logs) | ./modules/cloudwatch-logs | n/a |
| <a name="module_lb_logs"></a> [lb\_logs](#module\_lb\_logs) | ./modules/lb-logs | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_log_groups"></a> [cloudwatch\_log\_groups](#input\_cloudwatch\_log\_groups) | CloudWatch Log Group names to stream to Honeycomb | `list(string)` | n/a | yes |
| <a name="input_cloudwatch_logs_integration_name"></a> [cloudwatch\_logs\_integration\_name](#input\_cloudwatch\_logs\_integration\_name) | A name for this Integration. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Optional. The environment this code is running in. If set, will be added as 'env' to each event. | `string` | `""` | no |
| <a name="input_filter_fields"></a> [filter\_fields](#input\_filter\_fields) | Optional. Strings to specify which field names to remove from events. | `list(string)` | `[]` | no |
| <a name="input_honeycomb_api_host"></a> [honeycomb\_api\_host](#input\_honeycomb\_api\_host) | The name of the S3 bucket Kinesis uses for backup data. | `string` | `"https://api.honeycomb.io"` | no |
| <a name="input_honeycomb_api_key"></a> [honeycomb\_api\_key](#input\_honeycomb\_api\_key) | Your Honeycomb team's API key. | `string` | n/a | yes |
| <a name="input_honeycomb_dataset"></a> [honeycomb\_dataset](#input\_honeycomb\_dataset) | Honeycomb Dataset where events will be sent. | `string` | `"lb-access-logs"` | no |
| <a name="input_honeycomb_dataset_name"></a> [honeycomb\_dataset\_name](#input\_honeycomb\_dataset\_name) | Your Honeycomb dataset name. | `string` | n/a | yes |
| <a name="input_http_buffering_interval"></a> [http\_buffering\_interval](#input\_http\_buffering\_interval) | Kinesis Firehose http buffer interval, in seconds. | `number` | `60` | no |
| <a name="input_http_buffering_size"></a> [http\_buffering\_size](#input\_http\_buffering\_size) | Kinesis Firehose http buffer size, in MiB. | `number` | `15` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Optional. KMS Key ARN of key used to encript var.honeycomb\_api\_key. | `string` | `""` | no |
| <a name="input_lambda_function_memory"></a> [lambda\_function\_memory](#input\_lambda\_function\_memory) | Memory allocated to the Lambda function in MB. Must be between 128 and 10,240 (10GB), in 64MB increments. | `number` | `192` | no |
| <a name="input_lambda_function_timeout"></a> [lambda\_function\_timeout](#input\_lambda\_function\_timeout) | Timeout in seconds for lambda function. | `number` | `600` | no |
| <a name="input_lambda_package_bucket"></a> [lambda\_package\_bucket](#input\_lambda\_package\_bucket) | Internal. Override S3 bucket where lambda function zip is located. | `string` | `""` | no |
| <a name="input_lambda_package_key"></a> [lambda\_package\_key](#input\_lambda\_package\_key) | Internal. Override S3 key where lambda function zip is located. | `string` | `""` | no |
| <a name="input_lb_logs_integration_name"></a> [lb\_logs\_integration\_name](#input\_lb\_logs\_integration\_name) | A name for this Integration. | `string` | n/a | yes |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | Controls parsing of ALB or ELB (Classic) log format | `string` | `"alb"` | no |
| <a name="input_log_subscription_filter_pattern"></a> [log\_subscription\_filter\_pattern](#input\_log\_subscription\_filter\_pattern) | A valid CloudWatch Logs filter pattern for subscribing to a filtered stream of log events. Defaults to empty string to match everything. For more information, see the Amazon CloudWatch Logs User Guide. | `string` | `""` | no |
| <a name="input_rename_fields"></a> [rename\_fields](#input\_rename\_fields) | Optional. Map of fields to rename, old -> new. | `map(string)` | `{}` | no |
| <a name="input_s3_backup_mode"></a> [s3\_backup\_mode](#input\_s3\_backup\_mode) | Should we only backup to S3 data that failed delivery, or all data? | `string` | `"FailedDataOnly"` | no |
| <a name="input_s3_bucket_arn"></a> [s3\_bucket\_arn](#input\_s3\_bucket\_arn) | The full ARN of the bucket storing load balancer access logs. | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | A name of the S3 bucket that will store any logs that failed to be sent to Honeycomb. | `string` | n/a | yes |
| <a name="input_s3_buffer_interval"></a> [s3\_buffer\_interval](#input\_s3\_buffer\_interval) | The Firehose S3 buffer interval (in seconds). See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html | `number` | `400` | no |
| <a name="input_s3_buffer_size"></a> [s3\_buffer\_size](#input\_s3\_buffer\_size) | The size of the Firehose S3 buffer (in MiB). See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html | `number` | `10` | no |
| <a name="input_s3_compression_format"></a> [s3\_compression\_format](#input\_s3\_compression\_format) | The Firehose S3 compression format. May be GZIP, Snappy, Zip, or Hadoop-Compatiable Snappy. See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html | `string` | `"GZIP"` | no |
| <a name="input_s3_filter_prefix"></a> [s3\_filter\_prefix](#input\_s3\_filter\_prefix) | Optional. Prefix within logs bucket to restrict processing. | `string` | `""` | no |
| <a name="input_s3_force_destroy"></a> [s3\_force\_destroy](#input\_s3\_force\_destroy) | By default, AWS will decline to delete S3 buckets that are not empty:<br> `BucketNotEmpty: The bucket you tried to delete is not empty`.  These buckets<br> are used for backup if delivery or processing fail.<br> #<br> To allow this module's resources to be removed, we've set force\_destroy =<br> true, allowing non-empty buckets to be deleted. If you want to block this and<br> preserve those failed deliveries, you can set this value to false, though that<br> will leave terraform unable to cleanly destroy the module. | `bool` | `true` | no |
| <a name="input_sample_rate"></a> [sample\_rate](#input\_sample\_rate) | Sample rate. See https://honeycomb.io/docs/guides/sampling/. | `number` | `1` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional. Tags to add to resources created by this module. | `map(string)` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->