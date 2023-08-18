# terraform-aws-sqs-metric-stream


## Usage

Copy and paste into your Terraform configuration, insert the variables, and run terraform init:

```
module "cloudwatch-metric-stream" {
  source  = "nettempo/terraform-aws-s3-metric-stream/aws"
  version = "0.2.1"

  s3_bucket_firehose_backup	= "EXAMPLE_S3_BUCKET_NAME_FOR_FIREHOSE_BACKUP"
}
```
