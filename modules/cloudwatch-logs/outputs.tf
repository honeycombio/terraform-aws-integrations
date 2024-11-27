output "cloudwatch_log_subscription_filters" {
  value = [for filter in aws_cloudwatch_log_subscription_filter.this : filter.name]
}
