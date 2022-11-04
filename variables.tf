variable "honeycomb_api_key" {
  type        = string
  description = "Your Honeycomb team's API key."
  sensitive   = true
}

variable "cloudwatch_log_groups" {
  type        = list(string)
  description = "CloudWatch Log Group names to stream to Honeycomb"
  default     = []
}

variable "delivery_failure_s3_bucket_name" {
  type        = string
  description = "Name for S3 bucket that will be created to hold Kinesis Firehose delivery failures."
  default     = "honeycomb-firehose-failures-{REGION}"
}

variable "honeycomb_api_host" {
  type        = string
  default     = "https://api.honeycomb.io"
  description = "If you use a Secure Tenancy or other proxy, put its schema://host[:port] here."
}

variable "enable_cloudwatch_metrics" {
  type        = bool
  default     = false
  description = <<DESC
      Honeycomb Enterprise customers can enable CloudWatch Metrics collection by
      setting this to true.
  DESC
}
