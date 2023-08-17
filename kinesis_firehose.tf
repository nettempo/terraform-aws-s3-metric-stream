resource "aws_kinesis_firehose_delivery_stream" "cloudwatch" {
  name        = var.kinesis_firehose_delivery_stream_name
  destination = "http_endpoint"

  http_endpoint_configuration {
    name               = "Datadog"
    access_key         = var.cloudwatch_api_key
    buffering_interval = 60
    buffering_size     = 4
    retry_duration     = 60
    role_arn           = aws_iam_role.cloudwatch-firehose.arn
    s3_backup_mode     = "FailedDataOnly"
    url                = var.cloudwatch_firehose_endpoint

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = aws_cloudwatch_log_group.cloudwatch-metric-stream.name
      log_stream_name = aws_cloudwatch_log_stream.cloudwatch-metric-stream-http_endpoint_delivery.name
    }

    processing_configuration {
      enabled = false
    }

    request_configuration {
      content_encoding = "GZIP"
    }
  }

  s3_configuration {
    bucket_arn      = aws_s3_bucket.cloudwatch-firehose-backup.arn
    buffer_interval = 300
    buffer_size     = 5
    prefix          = var.s3_bucket_backup_prefix
    role_arn        = aws_iam_role.cloudwatch-firehose.arn

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = aws_cloudwatch_log_group.cloudwatch-metric-stream.name
      log_stream_name = aws_cloudwatch_log_stream.cloudwatch-metric-stream-s3_backup.name
    }
  }

  server_side_encryption {
    enabled = false
  }
}
