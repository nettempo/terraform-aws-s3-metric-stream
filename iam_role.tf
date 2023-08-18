resource "aws_iam_role" "cloudwatch_metric_stream" {
  name               = var.aws_iam_role_cloudwatch_metric_stream_name
  assume_role_policy = data.aws_iam_policy_document.cloudwatch_metric_stream_assume_role.json
  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/BasicRole_Boundary"
}

data "aws_iam_policy_document" "cloudwatch_metric_stream_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["streams.metrics.cloudwatch.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "cloudwatch_firehose" {
  name               = var.aws_iam_role_cloudwatch_firehose_name
  assume_role_policy = data.aws_iam_policy_document.cloudwatch_firehose_assume_role.json
  permissions_boundary = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/BasicRole_Boundary"
}

data "aws_iam_policy_document" "cloudwatch_firehose_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["firehose.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role_policy" "cloudwatch_metric_stream_firehose" {
  name   = var.aws_iam_role_policy_cloudwatch_metric_stream_firehose_name
  policy = data.aws_iam_policy_document.cloudwatch_metric_stream_firehose.json
  role   = aws_iam_role.cloudwatch_metric_stream.name
}

data "aws_iam_policy_document" "cloudwatch_metric_stream_firehose" {
  statement {
    actions = [
      "firehose:PutRecord",
      "firehose:PutRecordBatch",
    ]

    resources = [aws_kinesis_firehose_delivery_stream.cloudwatch.arn]
  }
}

resource "aws_iam_role_policy" "cloudwatch_firehose_s3" {
  name   = var.aws_iam_role_policy_cloudwatch_firehose_s3_name
  policy = data.aws_iam_policy_document.cloudwatch_firehose_s3.json
  role   = aws_iam_role.cloudwatch_firehose.name
}

data "aws_iam_policy_document" "cloudwatch_firehose_s3" {
  statement {
    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
    ]

    resources = [aws_s3_bucket.cloudwatch_firehose.arn]
  }

  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = ["${aws_s3_bucket.cloudwatch_firehose.arn}/*"]
  }
}
