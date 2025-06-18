variable "name" {
  type        = string
  description = "A name for this CloudWatch Kinesis Firehose Stream."

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 32
    error_message = "We use var.name as a name_prefix, so it must be 1-32 characters in length."
  }
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

# Optional variables for customer configuration
variable "honeycomb_api_host" {
  type        = string
  default     = "https://api.honeycomb.io"
  description = "If you use a Secure Tenancy or other proxy, put its schema://host[:port] here."
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

variable "enable_lambda_transform" {
  type        = bool
  default     = false
  description = "Enable a Lambda transform on the Kinesis Firehose to preprocess and structure the logs"
}

variable "lambda_transform_arn" {
  type        = string
  default     = ""
  description = "If enable_lambda_transform is set to true, specify a valid arn"
}

variable "lambda_processor_parameters" {
  type        = map(string)
  default     = {}
  description = <<DESC
Values passed as the Lambda processing_configuration.processors.parameters, as detailed
at https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream#processors.

Do not use the default values for BufferSizeInMBs (3) and BufferIntervalInSeconds (60) or you will trigger a provider bug (https://github.com/hashicorp/terraform-provider-aws/issues/9827) resulting in infinite diffs.
DESC
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

variable "s3_failure_bucket_arn" {
  type        = string
  description = "A name of the S3 bucket that will store any logs that failed to be sent to Honeycomb."
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

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to apply to resources created by this module."
}
