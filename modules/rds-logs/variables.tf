variable "name" {
  type        = string
  description = "A name for this CloudWatch Kinesis Firehose Stream."

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 32
    error_message = "We use var.name as a name_prefix, so it must be 1-32 characters in length."
  }
}

variable "db_name" {
  type        = string
  description = "Name of your RDS database."
}

variable "db_engine" {
  type        = string
  description = "Engine type on your RDS database"
  validation {
    condition = contains(["aurora-mysql", "aurora-postgresql", "mariadb", "sqlserver", "mysql", "oracle", "postgresql"],
    var.db_engine)
    error_message = "Not a valid database engine."
  }
}

variable "db_log_types" {
  type = list(string)
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

variable "s3_failure_bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket that will store any logs that failed to be sent to Honeycomb."
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

variable "lambda_function_architecture" {
  type        = string
  default     = "amd64"
  description = "Instruction set architecture for your Lambda function."
  validation {
    condition = contains(["amd64", "arm64"],
    var.lambda_function_architecture)
    error_message = "Not an allowed Lambda architecture."
  }
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

variable "tags" {
  type        = map(string)
  description = "Tags to add to resources created by this module."
  default     = null
}

variable "agentless_integrations_version" {
  type        = string
  description = "Version of https://github.com/honeycombio/agentless-integrations-for-aws to use. Default is LATEST, but note that specifying this does not automatically update the lambda to use the newest versions as they are released."
  default     = "LATEST"

  validation {
    error_message = "Version must be at least 4.0.0"
    condition     = can(regex("^([4-9]|[1-9][0-9]+)\\.[0-9]+\\.[0-9]+|LATEST$", var.agentless_integrations_version))
  }
}
