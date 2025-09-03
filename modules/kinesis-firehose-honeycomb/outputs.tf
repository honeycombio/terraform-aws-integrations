output "kinesis_firehose_delivery_stream_arn" {
  value = length(local.destinations) == 1 ? aws_kinesis_firehose_delivery_stream.http_stream[0].arn : aws_kinesis_firehose_delivery_stream.collector_stream[0].arn
}

output "otel_collector_service_url" {
  value       = length(local.destinations) > 1 ? aws_apprunner_service.otel_collector[0].service_url : null
  description = "The URL of the OpenTelemetry collector App Runner service (only available when using multiple destinations)"
}

output "otel_collector_service_arn" {
  value       = length(local.destinations) > 1 ? aws_apprunner_service.otel_collector[0].arn : null
  description = "The ARN of the OpenTelemetry collector App Runner service (only available when using multiple destinations)"
}
