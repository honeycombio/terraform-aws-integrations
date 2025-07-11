# Required variables
variable "name" {
  type        = string
  description = "A unique name for this CloudWatch Metric Stream."
  default     = "honeycomb-cloudwatch-metrics"

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
variable "honeycomb_api_host" {
  type        = string
  default     = "https://api.honeycomb.io"
  description = "If you use a Secure Tenancy or other proxy, put its schema://host[:port] here."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to apply to resources created by this module."
}

variable "include_filters" {
  type = list(object({
    namespace    = string
    metric_names = list(string)
  }))
  default     = []
  description = <<EOH
An optional list of inclusive CloudWatch Metric filters. If set, we'll only stream metrics matching these namespace and metric names.
Pass an empty list (`[]`) to `metric_names` to include all metrics for the namespace.
Mututally exclusive with `exclude_filters`.
EOH
}

variable "exclude_filters" {
  type = list(object({
    namespace    = string
    metric_names = list(string)
  }))
  default     = []
  description = <<EOH
An optional list of exclusive CloudWatch Metric filters. If set, we'll only stream metrics that do not match these namespace and metric names.
Pass an empty list (`[]`) to `metric_names` to exclude all metrics for the namespace.
Mututally exclusive with `exclude_filters`.
EOH
}

variable "namespace_include_filters" {
  type        = list(string)
  default     = []
  description = <<EOH
DEPRECATED: use `include_filters` instead.

An optional list of CloudWatch Metric namespaces to include. If set, we'll only stream metrics from these namespaces.
Mutually exclusive with `namespace_exclude_filters`.
EOH
}

variable "namespace_exclude_filters" {
  type        = list(string)
  default     = []
  description = <<EOH
DEPRECATED: use `include_filters` instead.

An optional list of CloudWatch Metric namespaces to exclude. If set, we'll only stream metrics that are not in these namespaces.
Mutually exclusive with `namespace_include_filters`.
EOH
}

variable "include_linked_accounts_metrics" {
  type        = bool
  default     = false
  description = "If you are creating a metric stream in a monitoring account, specify true to include metrics from source accounts that are linked to this monitoring account, in the metric stream."
}

variable "s3_failure_bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket that will store any logs that failed to be sent to Honeycomb."
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

variable "output_format" {
  type        = string
  default     = "opentelemetry1.0"
  description = "Output format of metrics. You should probably not modify this value; the default format is supported, but others may not be."

  validation {
    condition     = contains(["json", "opentelemetry1.0"], var.output_format)
    error_message = "Not an allowed output format."
  }
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
