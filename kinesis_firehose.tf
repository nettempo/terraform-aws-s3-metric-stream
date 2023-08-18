resource "aws_kinesis_firehose_delivery_stream" "cloudwatch" {
  name        = var.kinesis_firehose_delivery_stream_name
  destination = "http_endpoint"

  extended_s3_configuration {
    bucket_arn      = aws_s3_bucket.cloudwatch_firehose.arn
    buffer_interval = 300
    buffer_size     = 5
    prefix          = var.s3_bucket_prefix
    role_arn        = aws_iam_role.cloudwatch_firehose.arn

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = aws_cloudwatch_log_group.cloudwatch_metric_stream.name
      log_stream_name = aws_cloudwatch_log_stream.cloudwatch_metric_stream_s3.name
    }
  }

  server_side_encryption {
    enabled = false
  }
}
