output "cloudwatch_metric_stream_arn" {
  value = aws_cloudwatch_metric_stream.metric-stream.arn
}

output "cloudwatch_metric_stream_name" {
  value = aws_cloudwatch_metric_stream.metric-stream.name
}
