data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
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
  description = "Honeycomb RDS Lambda Transform"
  policy      = data.aws_iam_policy_document.lambda.json
}

module "rds_lambda_transform" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.2"

  function_name = "honeycomb-rds-${var.db_engine}-log-parser"
  description   = "Parses RDS logs coming off of Kinesis Firehose, sending them back to the Firehose as structured JSON events"
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