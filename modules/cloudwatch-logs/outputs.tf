output "cloudwatch2honeycomb_log_subscription_filters" {
  value = values(aws_cloudwatch_log_subscription_filter.cwl_logfilter).*.name
}

output "cloudwatch2honeycomb_kinesis_firehose_delivery_stream" {
  value = aws_kinesis_firehose_delivery_stream.http_stream.name
}