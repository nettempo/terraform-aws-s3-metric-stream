resource "aws_cloudwatch_metric_stream" "cloudwatch" {
  name          = var.cloudwatch_metric_stream_name
  firehose_arn  = aws_kinesis_firehose_delivery_stream.cloudwatch.arn
  output_format = var.cloudwatch_metric_stream_output_format
  role_arn      = aws_iam_role.cloudwatch_metric_stream.arn

  dynamic "include_filter" {
    for_each = var.metric_stream_namespace_list
    iterator = namespace

    content {
      namespace = namespace.value
    }
  }
}
