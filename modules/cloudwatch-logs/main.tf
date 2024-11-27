module "kfh" {
  source = "../kinesis-firehose-honeycomb"

  name = var.name

  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = var.honeycomb_dataset_name

  enable_lambda_transform = var.enable_lambda_transform
  lambda_transform_arn    = var.lambda_transform_arn

  http_buffering_size     = var.http_buffering_size
  http_buffering_interval = var.http_buffering_interval

  s3_failure_bucket_arn = var.s3_failure_bucket_arn
  s3_backup_mode        = var.s3_backup_mode
  s3_buffer_size        = var.s3_buffer_size
  s3_buffer_interval    = var.s3_buffer_interval
  s3_compression_format = var.s3_compression_format

  tags = var.tags
}

resource "aws_cloudwatch_log_subscription_filter" "this" {
  for_each = toset(var.cloudwatch_log_groups)

  name            = "${each.key}-logs_subscription_filter"
  role_arn        = aws_iam_role.this.arn
  log_group_name  = each.key
  filter_pattern  = var.log_subscription_filter_pattern
  destination_arn = module.kfh.kinesis_firehose_delivery_stream_arn
}
