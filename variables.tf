variable "kinesis_firehose_delivery_stream_name" {
  type        = string
  default     = "cloudwatch"
  description = "The name of Kinesis Firehose"
}

variable "cloudwatch_log_group_name" {
  type        = string
  default     = "cloudwatch-metric-stream"
  description = "The name of the CloudWatch log group"
}

variable "cloudwatch_metric_stream_name" {
  type        = string
  default     = "cloudwatch"
  description = "The name of the CloudWatch Metric Stream"
}

variable "cloudwatch_metric_stream_output_format" {
  type        = string
  default     = "opentelemetry0.7"
  description = "The output format of the CloudWatch Metric Stream"

  validation {
    condition     = contains(["opentelemetry0.7", "json"], var.cloudwatch_metric_stream_output_format)
    error_message = "Allowed values for input_parameter are \"opentelemetry0.7\", \"json\"."
  }
}

variable "aws_iam_role_cloudwatch_metric_stream_name" {
  type        = string
  default     = "CloudwatchMetricStreamRole"
  description = "The name of the IAM Role for Cloudwatch Metric Stream"
}

variable "aws_iam_role_cloudwatch_firehose_name" {
  type        = string
  default     = "CloudwatchFirehoseRole"
  description = "The name of the IAM Role for Kinesis Firehose"
}

variable "aws_iam_role_policy_cloudwatch_metric_stream_firehose_name" {
  type        = string
  default     = "CloudwatchMetricStreamFirehosePolicy"
  description = "The name of the IAM Role Policy for Metric Stream to allow PutRecords to Firehose"
}

variable "aws_iam_role_policy_cloudwatch_firehose_s3_name" {
  type        = string
  default     = "CloudwatchFirehoseS3BackupPolicy"
  description = "The name of the IAM Role Policy for Firehose to allow PutObject to Firehose"
}

variable "s3_bucket_firehose" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "s3_bucket_prefix" {
  type        = string
  default     = "metrics/"
  description = "The prefix of the S3 bucket"
}

variable "metric_stream_namespace_list" {
  type        = list(string)
  default     = []
  description = "The list of the namespaces for CloudWatch Metric Stream"
}
