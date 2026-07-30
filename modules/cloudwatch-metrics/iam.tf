# https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-metric-streams-trustpolicy.html
resource "aws_iam_role" "this" {
  name                 = var.cloudwatch_metrics_role_name
  name_prefix          = var.cloudwatch_metrics_role_name == null ? var.name : null
  permissions_boundary = var.cloudwatch_metrics_role_permissions_boundary
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json
  tags                 = var.tags
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["streams.metrics.cloudwatch.amazonaws.com"]
    }
  }
}

# https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-metric-streams-trustpolicy.html
resource "aws_iam_role_policy" "this" {
  name_prefix = var.name
  role        = aws_iam_role.this.id
  policy      = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {
  statement {
    actions   = ["firehose:PutRecord", "firehose:PutRecordBatch"]
    resources = [module.kfh.kinesis_firehose_delivery_stream_arn]
  }
}
