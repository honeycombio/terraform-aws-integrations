module "cloudwatch_logs" {
  source = "honeycombio/integrations/aws//modules/cloudwatch-logs"

  name                  = "cwlogs-${random_pet.this.id}"
  cloudwatch_log_groups = [module.log_group.cloudwatch_log_group_name, "/aws/rds/instance/tf-integrations-rds-mysql-enabled-blowfish/slowquery"]

  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "cloudwatch-logs"
  # Users generally don't need to set this unless they're using Secure Tenancy
  honeycomb_api_host = var.honeycomb_api_host

  # firehose failure logs can be found here for troubleshooting
  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn
}

# dependencies

resource "random_pet" "this" {
  length = 2
}

module "log_group" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "~> 3.0"

  name              = "tf-integrations-${random_pet.this.id}"
  retention_in_days = 1
}

module "firehose_failure_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket        = "honeycomb-tf-integrations-failures-${random_pet.this.id}"
  force_destroy = true
}
