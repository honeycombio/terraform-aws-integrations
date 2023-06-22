data "aws_arn" "s3_bucket" {
  arn = var.s3_bucket_arn
}

data "aws_arn" "kms_key" {
  arn   = var.kms_key_arn
  count = var.kms_key_arn == "" ? 0 : 1
}

data "aws_region" "current" {}

locals {
  tags = merge(var.tags, {
    "Honeycomb Agentless" = true,
    "Terraform"           = true,
  })
}

data "aws_iam_policy_document" "lambda" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${var.s3_bucket_arn}/*"]
  }
  dynamic "statement" {
    for_each = var.kms_key_arn != "" ? ["allow_kms"] : []
    content {
      actions   = ["kms:Decrypt"]
      resources = [trimprefix(var.kms_key_arn, "key/")]
    }
  }
}

resource "aws_iam_policy" "lambda" {
  description = "Honeycomb Agentless Lambda"
  policy      = data.aws_iam_policy_document.lambda.json
}

module "s3_processor" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.2"

  function_name = var.name
  description   = "Parses LB access logs from S3, sending them to Honeycomb as structured events"
  handler       = "s3-handler"
  runtime       = "go1.x"
  memory_size   = var.lambda_function_memory
  timeout       = var.lambda_function_timeout

  create_package = false
  s3_existing_package = {
    bucket = coalesce(var.lambda_package_bucket, "honeycomb-integrations-${data.aws_region.current.name}")
    key    = coalesce(var.lambda_package_key, "agentless-integrations-for-aws/${var.agentless_integrations_version}/ingest-handlers.zip")
  }


  environment_variables = {
    PARSER_TYPE         = var.parser_type
    FORCE_GUNZIP        = true
    ENVIRONMENT         = var.environment
    HONEYCOMB_WRITE_KEY = var.honeycomb_api_key
    KMS_KEY_ID          = (var.kms_key_arn != "" ? data.aws_arn.kms_key[0].resource : "")
    API_HOST            = var.honeycomb_api_host
    DATASET             = var.honeycomb_dataset
    SAMPLE_RATE         = var.sample_rate
    SAMPLE_RATE_RULES   = jsonencode(var.sample_rate_rules)
    FILTER_FIELDS       = join(",", var.filter_fields)
    RENAME_FIELDS       = join(",", [for k, v in var.rename_fields : "${k}=${v}"])
  }

  attach_policy = true
  policy        = aws_iam_policy.lambda.arn

  attach_network_policy  = var.vpc_subnet_ids != null ? true : false
  vpc_subnet_ids         = var.vpc_subnet_ids != null ? var.vpc_subnet_ids : null
  vpc_security_group_ids = var.vpc_security_group_ids != null ? var.vpc_security_group_ids : null

  tags = local.tags
}

module "log_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws//modules/notification"
  version = "~> 3.0"

  bucket = data.aws_arn.s3_bucket.resource

  lambda_notifications = {
    processor = {
      function_arn  = module.s3_processor.lambda_function_arn
      function_name = module.s3_processor.lambda_function_name
      events        = ["s3:ObjectCreated:*"]
      filter_prefix = var.s3_filter_prefix
      filter_suffix = var.s3_filter_suffix
    }
  }
}
