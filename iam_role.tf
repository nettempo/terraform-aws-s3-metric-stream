resource "aws_iam_role" "cloudwatch-metric-stream" {
  name               = var.aws_iam_role_cloudwatch_metric_stream_name
  assume_role_policy = data.aws_iam_policy_document.cloudwatch-metric-stream-assume-role.json
}

data "aws_iam_policy_document" "cloudwatch-metric-stream-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["streams.metrics.cloudwatch.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "cloudwatch-firehose" {
  name               = var.aws_iam_role_cloudwatch_firehose_name
  assume_role_policy = data.aws_iam_policy_document.cloudwatch-firehose-assume-role.json
}

data "aws_iam_policy_document" "cloudwatch-firehose-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["firehose.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role_policy" "cloudwatch-metric-stream-firehose" {
  name   = var.aws_iam_role_policy_cloudwatch_metric_stream_firehose_name
  policy = data.aws_iam_policy_document.cloudwatch-metric-stream-firehose.json
  role   = aws_iam_role.cloudwatch-metric-stream.name
}

data "aws_iam_policy_document" "cloudwatch-metric-stream-firehose" {
  statement {
    actions = [
      "firehose:PutRecord",
      "firehose:PutRecordBatch",
    ]

    resources = [aws_kinesis_firehose_delivery_stream.cloudwatch.arn]
  }
}

resource "aws_iam_role_policy" "cloudwatch-firehose-s3-backup" {
  name   = var.aws_iam_role_policy_cloudwatch_firehose_s3_backup_name
  policy = data.aws_iam_policy_document.cloudwatch-firehose-s3-backup.json
  role   = aws_iam_role.cloudwatch-firehose.name
}

data "aws_iam_policy_document" "cloudwatch-firehose-s3-backup" {
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
    ]

    resources = [aws_s3_bucket.cloudwatch-firehose-backup.arn]
  }

  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = ["${aws_s3_bucket.cloudwatch-firehose-backup.arn}/*"]
  }
}
