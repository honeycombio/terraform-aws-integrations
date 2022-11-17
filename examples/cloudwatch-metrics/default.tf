module "cloudwatch_metric_stream_default" {
  source = "honeycombio/integrations/aws//cloudwatch-metrics"

  name                   = "cms_default"
  honeycomb_dataset_name = "cloudwatch-default"

  honeycomb_api_key = var.honeycomb_api_key

  # Users generally don't need to set this unless they're using Secure Tenancy
  honeycomb_api_host = var.honeycomb_api_host
}