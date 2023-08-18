resource "aws_s3_bucket" "cloudwatch_firehose" {
  bucket = var.s3_bucket_firehose
}
