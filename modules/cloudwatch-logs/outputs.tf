output "cloudwatch_log_subscription_filters" {
  value = var.use_order_independent_filter_resource_naming ? [for filter in aws_cloudwatch_log_subscription_filter.filters : filter.name] : aws_cloudwatch_log_subscription_filter.this[*].name
}
