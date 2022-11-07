# ---------------------------------------------------------------------------------------------------------------------
# SETUP ALL SUPPORTED AWS TO HONEYCOMB INTEGRATIONS
# These templates show an example of how to use the aws-honeycomb-integrations module to send observability data from
# various AWS services to Honeycomb. We deploy two Auto
# Note - the templates below reflect how to use the submodules available to setup integrations from Cloudwatch, S3 etc.
# Required variables need to be provided. Please see docs for details on what is expected.
# ---------------------------------------------------------------------------------------------------------------------

data "aws_region" "current" {}

locals {
  failure_bucket = replace(var.delivery_failure_s3_bucket_name, "{REGION}", data.aws_region.current.name)
}

module "failure_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket = local.failure_bucket
  acl    = "private"
}


module "cloudwatch_logs" {
  source = "./modules/cloudwatch-logs"
  name   = "honeycomb-cloudwatch-logs"

  cloudwatch_log_groups = var.cloudwatch_log_groups

  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "cloudwatch-logs"

  s3_failure_bucket_arn = module.failure_bucket.s3_bucket_arn
}

module "cloudwatch_metrics" {
  source = "./modules/cloudwatch-metrics"
  name   = "honeycomb-cloudwatch-metrics"

  count = var.enable_cloudwatch_metrics ? 1 : 0

  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "cloudwatch-metrics"

  s3_failure_bucket_arn = module.failure_bucket.s3_bucket_arn
}
