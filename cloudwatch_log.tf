resource "aws_cloudwatch_log_group" "cloudwatch-metric-stream" {
  name = var.cloudwatch_log_group_name
}

resource "aws_cloudwatch_log_stream" "cloudwatch-metric-stream-http_endpoint_delivery" {
  name           = "http_endpoint_delivery"
  log_group_name = aws_cloudwatch_log_group.cloudwatch-metric-stream.name
}

resource "aws_cloudwatch_log_stream" "cloudwatch-metric-stream-s3_backup" {
  name           = "s3_backup"
  log_group_name = aws_cloudwatch_log_group.cloudwatch-metric-stream.name
}
