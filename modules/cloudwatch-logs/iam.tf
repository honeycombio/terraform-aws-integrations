data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}

resource "aws_iam_role" "this" {
  name_prefix        = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = var.tags
}

data "aws_iam_policy_document" "assume_role" {
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

resource "aws_iam_role_policy" "cwl_policy" {
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
