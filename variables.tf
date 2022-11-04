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

variable "enable_cloudwatch_metrics" {
  type        = bool
  default     = false
  description = <<DESC
      Honeycomb Enterprise customers can enable CloudWatch Metrics collection by
      setting this to true.
  DESC
}

variable "enable_rds_logs" {
  type = bool
  default = false
}

variable "rds_db_name" {
  type = string
  default = ""
}

variable "rds_db_engine" {
  type = string
  default = ""
}

variable "rds_db_log_types" {
  type = list[string]
  default = []
}