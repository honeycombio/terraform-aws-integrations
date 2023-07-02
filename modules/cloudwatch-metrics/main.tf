locals {
  // until we remove the "namespace_" variables, we'll reconcile the inputs here
  // by converting the deprecated input into a similar looking object
  include_filters = length(var.include_filters) > 0 ? var.include_filters : [
    for f in var.namespace_include_filters : { namespace = f, metric_names = [] }
  ]
  exclude_filters = length(var.exclude_filters) > 0 ? var.exclude_filters : [
    for f in var.namespace_exclude_filters : { namespace = f, metric_names = [] }
  ]
}
module "kfh" {
  source = "../kinesis-firehose-honeycomb"

  name = var.name

  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = var.honeycomb_dataset_name

  http_buffering_size     = var.http_buffering_size
  http_buffering_interval = var.http_buffering_interval

  s3_failure_bucket_arn = var.s3_failure_bucket_arn
  s3_backup_mode        = var.s3_backup_mode
  s3_buffer_size        = var.s3_buffer_size
  s3_buffer_interval    = var.s3_buffer_interval
  s3_compression_format = var.s3_compression_format

  tags = var.tags
}

resource "aws_cloudwatch_metric_stream" "metric-stream" {
  name          = var.name
  role_arn      = aws_iam_role.this.arn
  firehose_arn  = module.kfh.kinesis_firehose_delivery_stream_arn
  output_format = var.output_format

  include_linked_accounts_metrics = var.include_linked_accounts_metrics

  # NOTE: include and exclude filters are _mutually exclusive_, you may not have
  # both (though this is difficult to enforce in variable validation.
  dynamic "include_filter" {
    for_each = local.include_filters

    content {
      namespace    = include_filter.value.namespace
      metric_names = include_filter.value.metric_names
    }
  }

  dynamic "exclude_filter" {
    for_each = local.exclude_filters

    content {
      namespace    = exclude_filter.value.namespace
      metric_names = exclude_filter.value.metric_names
    }
  }

  tags = var.tags
}
