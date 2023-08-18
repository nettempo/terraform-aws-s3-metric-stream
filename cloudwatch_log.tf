resource "aws_cloudwatch_log_group" "cloudwatch_metric_stream" {
  name = var.cloudwatch_log_group_name
  retention_in_days = 30
}

resource "aws_cloudwatch_log_stream" "cloudwatch_metric_stream_s3" {
  name           = "${var.s3_bucket_firehose}-s3"
  log_group_name = aws_cloudwatch_log_group.cloudwatch_metric_stream.name
}
