module "cloudwatch_metric_stream" {
  source = "honeycombio/integrations/aws//cloudwatch-metrics"

  name = "cloudwatch-metrics-complete"

  honeycomb_dataset_name = "cloudwatch-metrics"
  honeycomb_api_key      = var.honeycomb_api_key
  # Users generally don't need to set this unless they're using Secure Tenancy
  honeycomb_api_host = var.honeycomb_api_host

  # firehose failure logs can be found here for troubleshooting
  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn

  # optional filters to include or exclude AWS services - without them all metrics will be turned on
  # include and exclude cannot be used together, they are mutually exclusive
  namespace_include_filters = ["AWS/RDS", "AWS/ELB"]
  # namespace_exclude_filters = ["AWS/Lambda"]

  tags = {
    Environment = "sandbox"
  }
}

# dependencies

resource "random_pet" "this" {
  length = 2
}

module "firehose_failure_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket        = "honeycomb-tf-integrations-failures-${random_pet.this.id}"
  force_destroy = true
}
