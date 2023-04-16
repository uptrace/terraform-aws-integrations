# CloudWatch Metrics integration for Uptrace

This terraform modules configures AWS CloudWatch to send metrics to Uptrace.

## Usage

First, add the minimal Terraform configuration, which includes the required fields:

```tf
module "uptrace-aws-cloudwatch-metrics-integration" {
  source = "uptrace/integrations/aws//modules/cloudwatch-metrics"

  name = var.cloudwatch_metrics_integration_name // A name for the Integration.

  uptrace_dsn      = var.UPTRACE_DSN

  # firehose failure logs can be found here for troubleshooting
  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn

  # optional filters to include or exclude AWS services - without them all metrics will be turned on
  # include and exclude cannot be used together, they are mutually exclusive
  # namespace_include_filters = ["AWS/RDS", "AWS/ELB"]
  # namespace_exclude_filters = ["AWS/Lambda"]
}

# dependencies

resource "random_pet" "this" {
  length = 2
}

module "firehose_failure_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket        = "uptrace-tf-integrations-failures-${random_pet.this.id}"
  force_destroy = true
}
```

Then, provide the Uptrace DSN for Terraform to use, by setting the `UPTRACE_DSN` environment
variable.

```shell
export TF_VAR_UPTRACE_DSN=$UPTRACE_DSN
```

Then, set up AWS credentials for the intended AWS account where the resources will be created and
managed. Please refer to Terraform documentation for more details and options.

```
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION
```

Now apply the changes:

```shell
terraform plan
terraform apply
```

See [example](../../example/cloudwatch-metrics) for more details.
