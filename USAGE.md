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
| <a name="module_cloudwatch_logs_to_honeycomb_integration"></a> [cloudwatch\_logs\_to\_honeycomb\_integration](#module\_cloudwatch\_logs\_to\_honeycomb\_integration) | ./modules/cloudwatch-logs | n/a |
| <a name="module_lb_logs_to_honeycomb_integration"></a> [lb\_logs\_to\_honeycomb\_integration](#module\_lb\_logs\_to\_honeycomb\_integration) | ./modules/lb-logs | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_log_groups"></a> [cloudwatch\_log\_groups](#input\_cloudwatch\_log\_groups) | CloudWatch Log Group names to stream to Honeycomb | `list(string)` | n/a | yes |
| <a name="input_honeycomb_api_host"></a> [honeycomb\_api\_host](#input\_honeycomb\_api\_host) | If you use a Secure Tenancy or other proxy, put its schema://host[:port] here. | `string` | `"https://api.honeycomb.io"` | no |
| <a name="input_honeycomb_api_key"></a> [honeycomb\_api\_key](#input\_honeycomb\_api\_key) | Your Honeycomb team's API key. | `string` | n/a | yes |
| <a name="input_honeycomb_dataset_name"></a> [honeycomb\_dataset\_name](#input\_honeycomb\_dataset\_name) | Your Honeycomb dataset name. | `string` | n/a | yes |
| <a name="input_log_subscription_filter_pattern"></a> [log\_subscription\_filter\_pattern](#input\_log\_subscription\_filter\_pattern) | A valid CloudWatch Logs filter pattern for subscribing to a filtered stream of log events. Defaults to empty string to match everything. For more information, see the Amazon CloudWatch Logs User Guide. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | A name for this CloudWatch Kinesis Firehose Stream. | `string` | n/a | yes |
| <a name="input_s3_bucket_arn"></a> [s3\_bucket\_arn](#input\_s3\_bucket\_arn) | The full ARN of the bucket storing load balancer access logs. | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | A name of the S3 bucket that will store any logs that failed to be sent to Honeycomb. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->