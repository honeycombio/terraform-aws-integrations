module "cloudwatch_metric_stream" {
  source = "honeycombio/integrations/aws//modules/cloudwatch-metrics"

  name = "cloudwatch-metrics-complete"

  honeycomb_dataset_name = "cloudwatch-metrics"
  honeycomb_api_key      = var.honeycomb_api_key
  # Users generally don't need to set this unless they're using Secure Tenancy
  honeycomb_api_host = var.honeycomb_api_host

  # firehose failure logs can be found here for troubleshooting
  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn

  # include and exclude cannot be used together, they are mutually exclusive
  # ONLY send these namepaces and metrics
  include_filters = [
    {
      namespace = "AWS/EC2"
      metric_names = [
        "CPUUtilization",
        "CPUCreditBalance",
        "NetworkIn",
        "NetworkOut",
      ]
    },
    {
      namespace    = "AWS/ELB"
      metric_names = [] # include all metrics
    }
  ]

  # send all namespaces and metrics EXCEPT these
  # exclude_filters = [
  #   {
  #     namespace = "AWS/Lambda"
  #     metric_names = [] # exclude all metrics
  #   }
  # ]

  tags = {
    Environment = "sandbox"
  }
}

resource "random_pet" "this" {
  length = 2
}

module "firehose_failure_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket        = "honeycomb-tf-integrations-failures-${random_pet.this.id}"
  force_destroy = true
}
