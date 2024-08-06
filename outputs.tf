output "kinesis_firehose_delivery_stream_name" {
  value = aws_kinesis_firehose_delivery_stream.cloudwatch.name
}

output "cloudwatch_log_group_name" {
    value = aws_cloudwatch_log_group.cloudwatch_metric_stream.name
}

output "cloudwatch_metric_stream_name" {
    value = aws_cloudwatch_metric_stream.cloudwatch.name
}

output "cloudwatch_metric_stream_output_format" {
    value = aws_cloudwatch_metric_stream.cloudwatch.output_format
}

output "aws_iam_role_cloudwatch_metric_stream_name" {
    value = aws_iam_role.cloudwatch_metric_stream.name
}

output "aws_iam_role_cloudwatch_firehose_name" {
    value = aws_iam_role.cloudwatch_firehose.name
}

output "aws_iam_role_policy_cloudwatch_metric_stream_firehose_name" {
    value = aws_iam_role_policy.cloudwatch_metric_stream_firehose.name
}

output "aws_iam_role_policy_cloudwatch_firehose_s3_name" {
    value = aws_iam_role_policy.cloudwatch_firehose_s3.name
}

output "sqs_queue_name" {
  value = aws_sqs_queue.metrics_stream.name
}