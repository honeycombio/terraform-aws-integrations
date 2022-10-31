data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}

resource "aws_s3_bucket_acl" "aws_s3_bucket_acl" {
  bucket = aws_s3_bucket.temp_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket" "temp_bucket" {
  bucket = "temp-bucket-cw-logs-honeycomb"

  # 'true' allows terraform to delete this bucket even if it is not empty.
  force_destroy = var.s3_force_destroy
}

data "aws_iam_policy_document" "firehose-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "firehose_s3_role" {
  name               = "firehose_s3_role"
  assume_role_policy = data.aws_iam_policy_document.firehose-assume-role-policy.json
}

data "aws_iam_policy_document" "firehose_s3_policy_document" {
  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.temp_bucket.arn}",
      "${aws_s3_bucket.temp_bucket.arn}/*"
    ]
  }
}

resource "aws_iam_role_policy" "firehose_s3_policy" {
  name   = "firehose_s3_policy_${local.region}"
  role   = aws_iam_role.firehose_s3_role.id
  policy = data.aws_iam_policy_document.firehose_s3_policy_document.json
}

resource "aws_kinesis_firehose_delivery_stream" "http_stream" {
  name        = "cloudwatch-logs-to-honeycomb_firehose_delivery_stream"
  destination = "http_endpoint"

  s3_configuration {
    role_arn   = aws_iam_role.firehose_s3_role.arn
    bucket_arn = aws_s3_bucket.temp_bucket.arn

    buffer_size        = var.s3_buffer_size
    buffer_interval    = var.s3_buffer_interval
    compression_format = var.s3_compression_format
  }

  http_endpoint_configuration {
    url                = "${var.honeycomb_api_host}/1/kinesis_events/${var.honeycomb_dataset_name}"
    name               = "honeycomb"
    access_key         = var.honeycomb_api_key
    role_arn           = aws_iam_role.firehose_s3_role.arn
    s3_backup_mode     = var.s3_backup_mode
    buffering_size     = var.http_buffering_size
    buffering_interval = var.http_buffering_interval

    request_configuration {
      content_encoding = "GZIP"
    }
  }
}

resource "aws_cloudwatch_log_subscription_filter" "cwl_logfilter" {
  name            = "${var.cloudwatch_log_group}-logs_subscription_filter"
  role_arn        = aws_iam_role.cwl_to_firehose.arn
  log_group_name  = var.cloudwatch_log_group
  filter_pattern  = ""
  destination_arn = aws_kinesis_firehose_delivery_stream.http_stream.arn
}

data "aws_iam_policy_document" "logs-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["logs.${local.region}.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "aws:SourceArn"

      values = [
        "arn:aws:logs:${local.region}:${local.account_id}:*"
      ]
    }
  }
}

resource "aws_iam_role" "cwl_to_firehose" {
  name               = "cwl_role_${local.region}"
  assume_role_policy = data.aws_iam_policy_document.logs-assume-role-policy.json
}

data "aws_iam_policy_document" "cwl_policy_document" {
  statement {
    actions   = ["firehose:*"]
    resources = ["arn:aws:firehose:${local.region}:${local.account_id}:*"]
  }
}

resource "aws_iam_role_policy" "cwl_policy" {
  name = "cwl_role_policy_${local.region}"
  role = aws_iam_role.cwl_to_firehose.id

  policy = data.aws_iam_policy_document.cwl_policy_document.json
}