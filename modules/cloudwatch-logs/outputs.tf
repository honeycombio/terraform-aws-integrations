output "cloudwatch_log_subscription_filters" {
  value = values(aws_cloudwatch_log_subscription_filter.cwl_logfilter).*.name
}
