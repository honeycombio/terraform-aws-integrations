variable "name" {
  type        = string
  description = "A name for this CloudWatch Kinesis Firehose Stream."
}

variable "s3_bucket_name" {
  type        = string
  description = "A name of the S3 bucket that will store any logs that failed to be sent to Honeycomb."
}

variable "cloudwatch_log_groups" {
  type        = list(string)
  description = "CloudWatch Log Group names to stream to Honeycomb"
}

variable "honeycomb_dataset_name" {
  type        = string
  description = "Your Honeycomb dataset name."
}

variable "honeycomb_api_key" {
  type        = string
  description = "Your Honeycomb team's API key."
  sensitive   = true
}

variable "s3_bucket_arn" {
  type        = string
  description = "The full ARN of the bucket storing load balancer access logs."
}

# Optional variables for customer configuration
variable "log_subscription_filter_pattern" {
  type        = string
  description = "A valid CloudWatch Logs filter pattern for subscribing to a filtered stream of log events. Defaults to empty string to match everything. For more information, see the Amazon CloudWatch Logs User Guide."
  default     = ""
}

variable "honeycomb_api_host" {
  type        = string
  default     = "https://api.honeycomb.io"
  description = "If you use a Secure Tenancy or other proxy, put its schema://host[:port] here."
}

