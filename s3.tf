resource "aws_s3_bucket" "cloudwatch-firehose-backup" {
  bucket = var.s3_bucket_firehose_backup
}
