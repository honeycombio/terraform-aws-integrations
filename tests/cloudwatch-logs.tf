
module "cloudwatch_logs" {
  source = "../modules/cloudwatch-logs"

  name                  = "cwlogs-${random_pet.this.id}"
  cloudwatch_log_groups = [module.log_group.cloudwatch_log_group_name]

  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "cloudwatch-logs"

  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn
}

module "log_group" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "~> 3.0"

  name              = "tf-integrations-${random_pet.this.id}"
  retention_in_days = 1
}
