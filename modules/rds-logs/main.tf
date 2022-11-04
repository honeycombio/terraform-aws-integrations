data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
  log_groups = [ for log_type in var.db_log_types: "aws/rds/instance/${var.db_name}/${log_type}"]
  enable_lambda_transform = var.db_engine == "mysql" || var.db_engine == "postgresql"
  tags = merge(var.tags, {
    "Honeycomb Agentless" = true,
    "Terraform"           = true,
  })
}

data "aws_iam_policy_document" "lambda" {
  statement {
    actions   = ["firehose:PutRecordBatch"]
    resources = ["arn:aws:firehose:${local.region}:${local.account_id}:deliverystream/${var.firehose_name}"]
  }
}

resource "aws_iam_policy" "lambda" {
  count = local.enable_lambda_transform ? 1 : 0
  description = "Honeycomb RDS Lambda Transform"
  policy      = data.aws_iam_policy_document.lambda.json
}

module "rds_lambda_transform" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.2"

  count = local.enable_lambda_transform ? 1 : 0

  function_name = "honeycomb-rds-${var.db_engine}-log-parser"
  description   = "Parses RDS logs coming off of Kinesis Firehose, sending them back to the Firehose as structured JSON events."
  handler       = "rds-${var.db_engine}-kfh-transform"
  runtime       = "go1.x"
  memory_size   = var.lambda_function_memory
  timeout       = var.lambda_function_timeout

  create_package = false
  s3_existing_package = {
    bucket = coalesce(var.lambda_package_bucket, "honeycomb-integrations-${data.aws_region.current.name}")
    key    = coalesce(var.lambda_package_key, "agentless-integrations-for-aws/LATEST/ingest-handlers.zip")
  }

  attach_policy = true
  policy        = aws_iam_policy.lambda.arn

  tags = local.tags
}

module "cloudwatch_logs" {
  source = "./modules/cloudwatch-logs"
  name   = var.name

  cloudwatch_log_groups  = local.log_groups
  honeycomb_api_key      = var.honeycomb_api_key      
  honeycomb_dataset_name = var.honeycomb_dataset_name 
  s3_failure_bucket_arn = var.failure_bucket.s3_bucket_arn
  enable_lambda_transform = local.enable_lambda_transform
  lambda_transform_arn = local.enable_lambda_transform ? module.rds_lambda_transform.output.lambda_function_arn : ""
}
