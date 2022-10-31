resource "aws_iam_role_policy" "firehose_s3_policy" {
  name   = "firehose_s3_policy_${local.region}"
  role   = aws_iam_role.firehose_s3_role.id
  policy = data.aws_iam_policy_document.firehose_s3_policy_document.json
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