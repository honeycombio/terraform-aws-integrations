# Honeycomb Terraform AWS Integrations

[![OSS Lifecycle](https://img.shields.io/osslifecycle/honeycombio/terraform-aws-integrations)](https://github.com/honeycombio/home/blob/main/honeycomb-oss-lifecycle-and-practices.md)
[![Terraform Registry](https://img.shields.io/github/v/release/honeycombio/terraform-aws-integrations?color=5e4fe3&label=Terraform%20Registry&logo=terraform&sort=semver)](https://registry.terraform.io/modules/honeycombio/integrations/aws/latest)

This repo contains a set of modules in the [modules folder](https://github.com/honeycombio/terraform-aws-integrations/tree/main/modules) for resources in [AWS](https://aws.amazon.com/) using [Terraform](https://www.terraform.io/) to send observability data to [Honeycomb](https://www.honeycomb.io/).

## 📣 Adopting version 1.0.0

As of `v1.0.0` of this module, version 5 of the AWS Provider is required.
If you still need support for version 4 of the AWS Provider, continue to use `v0.5.0`.

## How does this work?

![AWS Integrations architecture](https://github.com/honeycombio/terraform-aws-integrations/blob/main/docs/overview.png?raw=true)

## Supported Integrations

Available supported integrations include:

* [CloudWatch Logs](https://github.com/honeycombio/terraform-aws-integrations/tree/main/modules/cloudwatch-logs)
* [CloudWatch Metrics](https://github.com/honeycombio/terraform-aws-integrations/tree/main/modules/cloudwatch-metrics)
* [RDS Logs](https://github.com/honeycombio/terraform-aws-integrations/tree/main/modules/rds-logs)
* [Logs from a S3 Bucket](https://github.com/honeycombio/terraform-aws-integrations/tree/main/modules/s3-logfile)

To use an individual Terraform integration, refer to the integration's README.
Otherwise, refer to the [configuration instructions](#usage) below to configure all supported integrations.

## Usage

First, add the minimal Terraform configuration, which includes the required fields for all [supported Terraform integrations](#supported-integrations):

```hcl
module "honeycomb-aws-integrations" {
  source = "honeycombio/integrations/aws"

  # aws cloudwatch logs integration
  cloudwatch_log_groups = [module.log_group.cloudwatch_log_group_name] // CloudWatch Log Group names to stream to Honeycomb.

  # aws rds logs integration
  enable_rds_logs  = true
  rds_db_name      = var.db_name
  rds_db_engine    = "mysql"
  rds_db_log_types = ["slowquery"] // valid types include general, slowquery, error, and audit (audit will be unstructured)

  # aws metrics integration
  # enable_cloudwatch_metrics = true

  # s3 logfile - alb access logs
  s3_bucket_arn  = var.s3_bucket_arn
  s3_parser_type = "alb" // valid types are alb, elb, cloudfront, vpc-flow-log, s3-access, json, and keyval

  #honeycomb
  honeycomb_api_key = var.honeycomb_api_key             // Honeycomb API key.
  honeycomb_dataset = "terraform-aws-integrations-test" // Your Honeycomb dataset name that will receive the logs.

  # Users generally don't need to set this unless they're using Secure Tenancy
  honeycomb_api_host = var.honeycomb_api_host
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

Examples that use this module can be found in [`examples/`](https://github.com/honeycombio/terraform-aws-integrations/tree/main/examples/complete).

## Development

### Tests

Test cases that run against local code are in [`tests/`](https://github.com/honeycombio/terraform-aws-integrations/tree/main/tests).
To set up:

1. Set the API key used by Terraform setting the `TF_VAR_HONEYCOMB_API_KEY` environment variable.

```bash
export TF_VAR_HONEYCOMB_API_KEY=$HONEYCOMB_API_KEY
```

2. Set up AWS credentials.
   Please see [Terraform documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration) for more details and options.

```bash
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
```

3. Run `terraform init` to initialize the working directory.

4. `terraform plan` and `terraform apply` will now work as expected, as will
   `terraform destroy`.

5. Test cases also run as part of the pipeline.
   See [test-terraform-module.yml](https://github.com/honeycombio/terraform-aws-integrations/blob/main/.github/workflows/test-terraform-module.yml)

### Docs

Configuration option documentation is autogenerated by running `make generate-docs`, and put in each module's [USAGE.md](https://github.com/honeycombio/terraform-aws-integrations/blob/main/USAGE.md).

Please regenerate and commit before merging any changes to this repository.

### Linters

We use [tflint](https://github.com/terraform-linters/tflint) and `terraform fmt`, and enforce this linting with a [GitHub Action](.github/workflows/tflint.yml).

You can run `make terraform-format` to automatically fix formatting issues.

## Contributions

Features, bug fixes and other changes to this module are gladly accepted.
Please open issues or a pull request with your change.

All contributions will be released under the Apache License 2.0.
