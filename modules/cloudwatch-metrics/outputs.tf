output "cloudwatch_metric_stream_arn" {
  value = aws_cloudwatch_metric_stream.metric-stream.arn
}

output "cloudwatch_metric_stream_name" {
  value = aws_cloudwatch_metric_stream.metric-stream.name
}

output "otel_collector_service_url" {
  value       = length(var.additional_destinations) > 0 ? nonsensitive(module.kfh.otel_collector_service_url) : null
  description = "The URL of the OpenTelemetry collector App Runner service (only available when using multiple destinations)"
}

output "otel_collector_service_arn" {
  value       = length(var.additional_destinations) > 0 ? nonsensitive(module.kfh.otel_collector_service_arn) : null
  description = "The ARN of the OpenTelemetry collector App Runner service (only available when using multiple destinations)"
}
