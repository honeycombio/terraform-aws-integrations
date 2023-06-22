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

  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced"
  block_public_policy      = true
  block_public_acls        = true
  ignore_public_acls       = true
  restrict_public_buckets  = true
}


module "cloudwatch_logs" {
  source = "./modules/cloudwatch-logs"
  name   = "honeycomb-cloudwatch-logs"

  count                 = length(var.cloudwatch_log_groups) > 0 ? 1 : 0
  cloudwatch_log_groups = var.cloudwatch_log_groups

  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "cloudwatch-logs"

  s3_failure_bucket_arn = module.failure_bucket.s3_bucket_arn

  tags = var.tags
}

module "rds_logs" {
  source = "./modules/rds-logs"
  name   = "honeycomb-rds-cloudwatch-logs"

  count = var.enable_rds_logs ? 1 : 0

  db_name                = var.rds_db_name
  db_engine              = var.rds_db_engine
  db_log_types           = var.rds_db_log_types
  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "rds-${var.rds_db_engine}-logs"

  s3_failure_bucket_arn = module.failure_bucket.s3_bucket_arn

  tags = var.tags
}

module "cloudwatch_metrics" {
  source = "./modules/cloudwatch-metrics"
  name   = "honeycomb-cloudwatch-metrics"

  count = var.enable_cloudwatch_metrics ? 1 : 0

  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "cloudwatch-metrics"

  s3_failure_bucket_arn = module.failure_bucket.s3_bucket_arn

  tags = var.tags
}

module "s3_logfile" {
  source = "./modules/s3-logfile"
  name   = "honeycomb-s3-logfile"

  count = var.s3_bucket_arn != "" ? 1 : 0

  honeycomb_api_key  = var.honeycomb_api_key
  honeycomb_api_host = var.honeycomb_api_host

  parser_type      = var.s3_parser_type
  s3_bucket_arn    = var.s3_bucket_arn
  s3_filter_prefix = var.s3_filter_prefix
  s3_filter_suffix = var.s3_filter_suffix
  sample_rate      = var.sample_rate

  vpc_subnet_ids         = var.vpc_subnet_ids != null ? var.vpc_subnet_ids : null
  vpc_security_group_ids = var.vpc_security_group_ids != null ? var.vpc_security_group_ids : null

  tags = var.tags
}
