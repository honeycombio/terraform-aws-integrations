module "cloudwatch_metric_stream_with_tags" {
  source = "honeycombio/integrations/aws//cloudwatch-metrics"

  name                   = "cms_with_tags"
  honeycomb_dataset_name = "cloudwatch-with-tags"

  honeycomb_api_key = var.honeycomb_api_key

  # Users generally don't need to set this unless they're using Secure Tenancy,
  # but it's here to enable our tests to run.
  honeycomb_api_host = var.honeycomb_api_host

  tags = {
    Environment = "sandbox"
  }
}
