
module "cloudwatch_logs" {
  source = "../modules/cloudwatch-logs"

  name                  = "cwlogs-${random_pet.this.id}"
  cloudwatch_log_groups = [module.log_group.cloudwatch_log_group_name]

  // explicitly named roles with a permissions boundary; the rds-logs test
  // case covers this module with both inputs left null
  cloudwatch_logs_role_name                 = "cwlogs-${random_pet.this.id}-logs"
  cloudwatch_logs_role_permissions_boundary = aws_iam_policy.permissions_boundary.arn
  firehose_role_name                        = "cwlogs-${random_pet.this.id}-firehose"
  firehose_role_permissions_boundary        = aws_iam_policy.permissions_boundary.arn

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
