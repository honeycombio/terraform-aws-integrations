output "cloudwatch_log_subscription_filters" {
  value = aws_cloudwatch_log_subscription_filter.this[*].name
}
