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
| <a name="module_cloudwatch_logs"></a> [cloudwatch\_logs](#module\_cloudwatch\_logs) | ./modules/cloudwatch-logs | n/a |
| <a name="module_cloudwatch_metrics"></a> [cloudwatch\_metrics](#module\_cloudwatch\_metrics) | ./modules/cloudwatch-metrics | n/a |
| <a name="module_failure_bucket"></a> [failure\_bucket](#module\_failure\_bucket) | terraform-aws-modules/s3-bucket/aws | ~> 3.0 |
| <a name="module_rds_logs"></a> [rds\_logs](#module\_rds\_logs) | ./modules/rds-logs | n/a |
| <a name="module_s3_logfile"></a> [s3\_logfile](#module\_s3\_logfile) | ./modules/s3-logfile | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_log_groups"></a> [cloudwatch\_log\_groups](#input\_cloudwatch\_log\_groups) | CloudWatch Log Group names to stream to Honeycomb | `list(string)` | `[]` | no |
| <a name="input_delivery_failure_s3_bucket_name"></a> [delivery\_failure\_s3\_bucket\_name](#input\_delivery\_failure\_s3\_bucket\_name) | Name for S3 bucket that will be created to hold Kinesis Firehose delivery failures. | `string` | `"honeycomb-firehose-failures-{REGION}"` | no |
| <a name="input_enable_cloudwatch_metrics"></a> [enable\_cloudwatch\_metrics](#input\_enable\_cloudwatch\_metrics) | n/a | `bool` | `false` | no |
| <a name="input_enable_rds_logs"></a> [enable\_rds\_logs](#input\_enable\_rds\_logs) | n/a | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment this code is running in. If set, will be added as 'env' to each event. | `string` | `""` | no |
| <a name="input_honeycomb_api_host"></a> [honeycomb\_api\_host](#input\_honeycomb\_api\_host) | If you use a Secure Tenancy or other proxy, put its schema://host[:port] here. | `string` | `"https://api.honeycomb.io"` | no |
| <a name="input_honeycomb_api_key"></a> [honeycomb\_api\_key](#input\_honeycomb\_api\_key) | Your Honeycomb team's API key. | `string` | n/a | yes |
| <a name="input_honeycomb_dataset"></a> [honeycomb\_dataset](#input\_honeycomb\_dataset) | Honeycomb Dataset where events will be sent. | `string` | `"lb-access-logs"` | no |
| <a name="input_http_buffering_interval"></a> [http\_buffering\_interval](#input\_http\_buffering\_interval) | Kinesis Firehose http buffer interval, in seconds. | `number` | `60` | no |
| <a name="input_http_buffering_size"></a> [http\_buffering\_size](#input\_http\_buffering\_size) | Kinesis Firehose http buffer size, in MiB. | `number` | `15` | no |
| <a name="input_rds_db_engine"></a> [rds\_db\_engine](#input\_rds\_db\_engine) | n/a | `string` | `""` | no |
| <a name="input_rds_db_log_types"></a> [rds\_db\_log\_types](#input\_rds\_db\_log\_types) | n/a | `list(string)` | `[]` | no |
| <a name="input_rds_db_name"></a> [rds\_db\_name](#input\_rds\_db\_name) | n/a | `string` | `""` | no |
| <a name="input_s3_backup_mode"></a> [s3\_backup\_mode](#input\_s3\_backup\_mode) | Should we only backup to S3 data that failed delivery, or all data? | `string` | `"FailedDataOnly"` | no |
| <a name="input_s3_bucket_arn"></a> [s3\_bucket\_arn](#input\_s3\_bucket\_arn) | The full ARN of the bucket storing logs - must pass s3\_parser\_type with this | `string` | `""` | no |
| <a name="input_s3_buffer_interval"></a> [s3\_buffer\_interval](#input\_s3\_buffer\_interval) | The Firehose S3 buffer interval (in seconds). See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html | `number` | `400` | no |
| <a name="input_s3_buffer_size"></a> [s3\_buffer\_size](#input\_s3\_buffer\_size) | The size of the Firehose S3 buffer (in MiB). See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html | `number` | `10` | no |
| <a name="input_s3_compression_format"></a> [s3\_compression\_format](#input\_s3\_compression\_format) | The Firehose S3 compression format. May be GZIP, Snappy, Zip, or Hadoop-Compatiable Snappy. See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html | `string` | `"GZIP"` | no |
| <a name="input_s3_filter_prefix"></a> [s3\_filter\_prefix](#input\_s3\_filter\_prefix) | Prefix within logs bucket to restrict processing. | `string` | `""` | no |
| <a name="input_s3_filter_suffix"></a> [s3\_filter\_suffix](#input\_s3\_filter\_suffix) | Suffix of files that should be processed. | `string` | `".gz"` | no |
| <a name="input_s3_force_destroy"></a> [s3\_force\_destroy](#input\_s3\_force\_destroy) | By default, AWS will decline to delete S3 buckets that are not empty:<br> `BucketNotEmpty: The bucket you tried to delete is not empty`.  These buckets<br> are used for backup if delivery or processing fail.<br> #<br> To allow this module's resources to be removed, we've set force\_destroy =<br> true, allowing non-empty buckets to be deleted. If you want to block this and<br> preserve those failed deliveries, you can set this value to false, though that<br> will leave terraform unable to cleanly destroy the module. | `bool` | `true` | no |
| <a name="input_s3_parser_type"></a> [s3\_parser\_type](#input\_s3\_parser\_type) | The type of logfile to parse. | `string` | `""` | no |
| <a name="input_sample_rate"></a> [sample\_rate](#input\_sample\_rate) | Sample rate - used for S3 logfiles only. See https://honeycomb.io/docs/guides/sampling/. | `number` | `1` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources created by this module. | `map(string)` | `null` | no |
| <a name="vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#vpc\_security\_group\_ids) | List of security group ids when Lambda Function should run in the VPC. | `list(string)` | `[]` | no |
| <a name="vpc_subnet_ids"></a> [vpc\_subnet\_ids](#vpc\_subnet\_ids) | List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets. | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
