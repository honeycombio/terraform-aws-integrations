variable "name" {
  type        = string
  description = "A name for this CloudWatch Kinesis Firehose Stream."
  default     = "honeycomb-cloudwatch-logs"

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 32
    error_message = "We use var.name as a name_prefix, so it must be 1-32 characters in length."
  }
}

variable "s3_failure_bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket that will store any logs that failed to be sent to Honeycomb."
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

# Additional sinks can be configured here.
variable "additional_destinations" {
  type = list(object({
    honeycomb_dataset_name = string,
    honeycomb_api_key      = string,
    honeycomb_api_host     = string,
  }))
  sensitive = true
  default   = []
}

# Optional variables for customer configuration
variable "enable_lambda_transform" {
  type        = bool
  description = "Enable a Lambda transform on the Kinesis Firehose to preprocess and structure the logs"
  default     = false
}

variable "lambda_transform_arn" {
  type        = string
  description = "If enable_lambda_transform is set to true, specify a valid arn"
  default     = ""
}
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

variable "s3_buffer_size" {
  type        = number
  default     = 10
  description = "In MiB. See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html"

  validation {
    condition     = var.s3_buffer_size >= 1 && var.s3_buffer_size <= 128
    error_message = "The s3_buffer_size must be 1-128 MiBs."
  }
}

variable "s3_buffer_interval" {
  type        = number
  default     = 400
  description = "In seconds. See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html"

  validation {
    condition     = var.s3_buffer_interval >= 60 && var.s3_buffer_interval <= 900
    error_message = "The s3_buffer_interval must be 60-900 seconds."
  }
}

variable "s3_compression_format" {
  type        = string
  default     = "GZIP"
  description = "May be GZIP, Snappy, Zip, or Hadoop-Compatiable Snappy. See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html"

  validation {
    condition = contains(["GZIP",
      "Snappy",
      "Zip",
      "Hadoop-Compatible Snappy"],
    var.s3_compression_format)
    error_message = "Not an allowed compression format."
  }
}

variable "s3_backup_mode" {
  type        = string
  default     = "FailedDataOnly"
  description = "Should we only backup to S3 data that failed delivery, or all data?"

  validation {
    condition = contains(["FailedDataOnly", "AllData"],
    var.s3_backup_mode)
    error_message = "Not an allowed s3_backup_mode."
  }
}

variable "s3_force_destroy" {
  type        = bool
  default     = true
  description = <<EOF
 By default, AWS will decline to delete S3 buckets that are not empty:
 `BucketNotEmpty: The bucket you tried to delete is not empty`.  These buckets
 are used for backup if delivery or processing fail.
 #
 To allow this module's resources to be removed, we've set force_destroy =
 true, allowing non-empty buckets to be deleted. If you want to block this and
 preserve those failed deliveries, you can set this value to false, though that
 will leave terraform unable to cleanly destroy the module.
 EOF
}


variable "http_buffering_size" {
  type        = number
  default     = 15
  description = "Kinesis Firehose http buffer size, in MiB."
}

variable "http_buffering_interval" {
  type        = number
  default     = 60
  description = "Kinesis Firehose http buffer interval, in seconds."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to apply to resources created by this module."
}

variable "use_order_independent_filter_resource_naming" {
  type        = bool
  description = "Use order-independent naming for log group subscription filter resources."
  default     = false
}
