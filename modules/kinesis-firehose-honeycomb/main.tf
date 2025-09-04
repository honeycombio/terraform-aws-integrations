data "aws_region" "current" {}

# Generate access key for OpenTelemetry collector if not provided
resource "random_password" "otel_access_key" {
  count   = length(local.destinations) > 1 && var.otel_access_key == "" ? 1 : 0
  length  = 32
  special = false
}

locals {
  region                    = data.aws_region.current.name
  actual_otel_access_key    = var.otel_access_key != "" ? var.otel_access_key : (length(local.destinations) > 1 ? random_password.otel_access_key[0].result : "")
  default_lambda_parameters = [{ "name" = "BufferSizeInMBs", "value" = 2 }, { "name" = "BufferIntervalInSeconds", "value" = 61 }]
  user_lambda_parameters    = [for k, v in var.lambda_processor_parameters : { "name" = k, "value" = v }]

  lambda_parameters = concat(
    [{ "name" = "LambdaArn", "value" = "${var.lambda_transform_arn}:$LATEST" }],
    local.default_lambda_parameters,
    local.user_lambda_parameters
  )

  destinations = concat([{
    honeycomb_dataset_name = var.honeycomb_dataset_name
    honeycomb_api_key      = var.honeycomb_api_key
    honeycomb_api_host     = var.honeycomb_api_host
    }],
    var.additional_destinations
  )

  # Create OpenTelemetry collector configuration as a structured object
  otel_config = {
    receivers = {
      awsfirehose = {
        endpoint    = "0.0.0.0:4433"
        record_type = "otlp_v1"
        access_key  = local.actual_otel_access_key
      }
    }

    exporters = {
      for idx, dest in local.destinations : "otlphttp/${idx}" => {
        endpoint = "${dest.honeycomb_api_host}/v1/metrics"
        headers = {
          "x-honeycomb-team"    = dest.honeycomb_api_key
          "x-honeycomb-dataset" = dest.honeycomb_dataset_name
        }
      }
    }

    processors = {
      batch = {
        timeout         = "300s"
        send_batch_size = 100000
      }
    }

    service = {
      pipelines = {
        metrics = {
          receivers  = ["awsfirehose"]
          processors = ["batch"]
          exporters  = [for idx, dest in local.destinations : "otlphttp/${idx}"]
        }
      }
    }
  }
}

resource "aws_kinesis_firehose_delivery_stream" "http_stream" {
  count       = length(local.destinations) == 1 ? 1 : 0
  name        = var.name
  destination = "http_endpoint"

  http_endpoint_configuration {
    url                = "${local.destinations[count.index].honeycomb_api_host}/1/kinesis_events/${local.destinations[count.index].honeycomb_dataset_name}"
    name               = "honeycomb"
    access_key         = local.destinations[count.index].honeycomb_api_key
    role_arn           = aws_iam_role.firehose_s3_role.arn
    s3_backup_mode     = var.s3_backup_mode
    buffering_size     = var.http_buffering_size
    buffering_interval = var.http_buffering_interval

    s3_configuration {
      role_arn   = aws_iam_role.firehose_s3_role.arn
      bucket_arn = var.s3_failure_bucket_arn

      buffering_size     = var.s3_buffer_size
      buffering_interval = var.s3_buffer_interval
      compression_format = var.s3_compression_format
    }

    request_configuration {
      content_encoding = "GZIP"
    }

    dynamic "processing_configuration" {
      for_each = var.lambda_transform_arn != "" ? ["allow_transform"] : []
      content {
        enabled = var.enable_lambda_transform

        processors {
          type = "Lambda"

          dynamic "parameters" {
            for_each = local.lambda_parameters
            content {
              parameter_name  = parameters.value.name
              parameter_value = parameters.value.value
            }
          }
        }
      }
    }
  }
}

resource "aws_apprunner_service" "otel_collector" {
  count        = length(local.destinations) > 1 ? 1 : 0
  service_name = "${var.name}-otel-collector"

  source_configuration {
    auto_deployments_enabled = false
    image_repository {
      image_configuration {
        port = "4433"
        runtime_environment_variables = {
          OTEL_CONFIG = jsonencode(local.otel_config)
        }
        start_command = "--config env:OTEL_CONFIG"
      }
      image_identifier      = "public.ecr.aws/honeycombio/honeycomb-opentelemetry-collector:v0.0.19"
      image_repository_type = "ECR_PUBLIC"
    }
  }

  instance_configuration {
    cpu    = "0.25 vCPU"
    memory = "0.5 GB"
  }

  network_configuration {
    ip_address_type = "IPV4"
    ingress_configuration {
      is_publicly_accessible = true
    }
  }

  observability_configuration {
    observability_enabled = false
  }

  tags = var.tags
}

resource "aws_kinesis_firehose_delivery_stream" "collector_stream" {
  count       = length(local.destinations) > 1 ? 1 : 0
  name        = "${var.name}-collector"
  destination = "http_endpoint"

  http_endpoint_configuration {
    url                = "https://${aws_apprunner_service.otel_collector[0].service_url}/"
    name               = "otel-collector"
    access_key         = local.actual_otel_access_key
    role_arn           = aws_iam_role.firehose_s3_role.arn
    s3_backup_mode     = var.s3_backup_mode
    buffering_size     = var.http_buffering_size
    buffering_interval = var.http_buffering_interval

    s3_configuration {
      role_arn   = aws_iam_role.firehose_s3_role.arn
      bucket_arn = var.s3_failure_bucket_arn

      buffering_size     = var.s3_buffer_size
      buffering_interval = var.s3_buffer_interval
      compression_format = var.s3_compression_format
    }

    request_configuration {
      content_encoding = "GZIP"
    }

    dynamic "processing_configuration" {
      for_each = var.lambda_transform_arn != "" ? ["allow_transform"] : []
      content {
        enabled = var.enable_lambda_transform

        processors {
          type = "Lambda"

          dynamic "parameters" {
            for_each = local.lambda_parameters
            content {
              parameter_name  = parameters.value.name
              parameter_value = parameters.value.value
            }
          }
        }
      }
    }
  }
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
  name_prefix        = var.name
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
      var.s3_failure_bucket_arn,
      "${var.s3_failure_bucket_arn}/*"
    ]
  }
}

resource "aws_iam_role_policy" "firehose_s3_policy" {
  name   = "firehose_s3_policy_${local.region}"
  role   = aws_iam_role.firehose_s3_role.id
  policy = data.aws_iam_policy_document.firehose_s3_policy_document.json
}

data "aws_iam_policy_document" "firehose_lambda_policy_document" {
  statement {
    actions = [
      "lambda:InvokeFunction",
      "lambda:GetFunctionConfiguration"
    ]
    resources = [
      "${var.lambda_transform_arn}:*"
    ]
  }
}

resource "aws_iam_role_policy" "firehose_lambda_policy" {
  count  = var.enable_lambda_transform ? 1 : 0
  name   = "firehose_lambda_policy_${local.region}"
  role   = aws_iam_role.firehose_s3_role.id
  policy = data.aws_iam_policy_document.firehose_lambda_policy_document.json
}
