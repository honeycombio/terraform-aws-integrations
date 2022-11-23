# TERRAFORM AWS RDS LOGS INTEGRATION

This repo contains a module for resources in [AWS](https://aws.amazon.com/) using [Terraform](https://www.terraform.io/) to send logs from AWS RDS to [Honeycomb](https://www.honeycomb.io/).

## How does this work?

![AWS RDS Integration overview](https://github.com/honeycombio/terraform-aws-integrations/blob/main/docs/rds-logs-overview.png?raw=true)

All required resources to setup an integration pipeline to take RDS logs from CloudWatch log groups and send them to Honeycomb can be created and managed via this module.

## Use

First, add the minimal Terraform configuration, which includes the required fields:

```hcl
module "honeycomb-aws-rds-logs-integration" {
  source = "honeycombio/integrations/aws//modules/rds-logs"

  name                   = "rds-logs-integration"
  db_engine              = "mysql"
  db_name                = "mysql-db-name"
  db_log_types           = ["slowquery"]
  honeycomb_api_key      = var.honeycomb_api_key // Your Honeycomb team's API key
  honeycomb_dataset_name = "rds-mysql-logs"

  s3_failure_bucket_arn = var.s3_bucket_arn      // The full ARN of the bucket storing Kinesis Firehose failure logs.
}
```

Then, set the Honeycomb API key for Terraform to use, by setting the `HONEYCOMB_API_KEY` environment variable.

```bash
export TF_VAR_HONEYCOMB_API_KEY=$HONEYCOMB_API_KEY
```

Then, set up AWS credentials for the intended AWS account where the resources will be created and managed.
Please refer to [Terraform documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration) for more details and options.

```bash
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
```

Now you can run `terraform plan/apply` in sequence.

For more configuration options, refer to [USAGE.md](https://github.com/honeycombio/terraform-aws-integrations/blob/main/USAGE.md).

## Examples

Examples that use this module can be found in [`examples/`](https://github.com/honeycombio/terraform-aws-integrations/tree/main/examples/rds-logs).

## Development

Refer to our [development documentation](https://github.com/honeycombio/terraform-aws-integrations#development) for details.

## Contributions

Features, bug fixes and other changes to this module are gladly accepted.
Please open issues or a pull request with your change.

All contributions will be released under the Apache License 2.0.
