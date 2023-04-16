# CloudWatch Logs integration for Uptrace

This terraform modules configures AWS CloudWatch to send metrics to Uptrace.

## Usage

First, add the minimal Terraform configuration, which includes the required fields:

```tf
module "cloudwatch_logs" {
  source = "uptrace/integrations/aws//modules/cloudwatch-logs"

  name                  = "cloudwatch-logs-${random_pet.this.id}"
  cloudwatch_log_groups = [module.log_group.cloudwatch_log_group_name]

  uptrace_dsn = var.uptrace_dsn

  # firehose failure logs can be found here for troubleshooting
  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn
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

See [example](../../example/cloudwatch-logs) for more details.
