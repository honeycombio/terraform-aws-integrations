variable "cloudwatch_logs_integration_name" {
  type        = string
  description = "A name for this Integration."
}

variable "lb_logs_integration_name" {
  type        = string
  description = "A name for this Integration."
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
  description = "The name of the S3 bucket Kinesis uses for backup data."
}

variable "s3_buffer_size" {
  type        = number
  default     = 10
  description = "The size of the Firehose S3 buffer (in MiB). See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html"

  validation {
    condition     = var.s3_buffer_size >= 1 && var.s3_buffer_size <= 128
    error_message = "The s3_buffer_size must be 1-128 MiBs."
  }
}

variable "s3_buffer_interval" {
  type        = number
  default     = 400
  description = "The Firehose S3 buffer interval (in seconds). See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html"

  validation {
    condition     = var.s3_buffer_interval >= 60 && var.s3_buffer_interval <= 900
    error_message = "The s3_buffer_interval must be 60-900 seconds."
  }
}

variable "s3_compression_format" {
  type        = string
  default     = "GZIP"
  description = "The Firehose S3 compression format. May be GZIP, Snappy, Zip, or Hadoop-Compatiable Snappy. See https://docs.aws.amazon.com/firehose/latest/dev/create-configure.html"

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

variable "environment" {
  type        = string
  description = "Optional. The environment this code is running in. If set, will be added as 'env' to each event."
  default     = ""
}

variable "honeycomb_dataset" {
  type        = string
  description = "Honeycomb Dataset where events will be sent."
  default     = "lb-access-logs"
}

variable "filter_fields" {
  type        = list(string)
  description = "Optional. Strings to specify which field names to remove from events."
  default     = []
}

variable "kms_key_arn" {
  type        = string
  description = "Optional. KMS Key ARN of key used to encript var.honeycomb_api_key."
  default     = ""
}

variable "lambda_function_memory" {
  type        = number
  default     = 192
  description = "Memory allocated to the Lambda function in MB. Must be between 128 and 10,240 (10GB), in 64MB increments."
}

variable "lambda_function_timeout" {
  type        = number
  description = "Timeout in seconds for lambda function."
  default     = 600
}

variable "lambda_package_bucket" {
  type        = string
  description = "Internal. Override S3 bucket where lambda function zip is located."
  default     = ""
}

variable "lambda_package_key" {
  type        = string
  description = "Internal. Override S3 key where lambda function zip is located."
  default     = ""
}

variable "load_balancer_type" {
  type        = string
  description = "Controls parsing of ALB or ELB (Classic) log format"
  default     = "alb"
  validation {
    condition     = contains(["alb", "elb"], var.load_balancer_type)
    error_message = "load_balancer_type must be either 'alb' or 'elb'"
  }
}

variable "rename_fields" {
  type        = map(string)
  description = "Optional. Map of fields to rename, old -> new."
  default     = {}
}

variable "s3_filter_prefix" {
  type        = string
  description = "Optional. Prefix within logs bucket to restrict processing."
  default     = ""
}

variable "sample_rate" {
  type        = number
  default     = 1
  description = "Sample rate. See https://honeycomb.io/docs/guides/sampling/."
}

variable "tags" {
  type        = map(string)
  description = "Optional. Tags to add to resources created by this module."
  default     = null
}
