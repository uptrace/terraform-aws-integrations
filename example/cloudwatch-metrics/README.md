# CloudWatch Metrics example for Uptrace

First, provide the Uptrace DSN for Terraform to use, by setting the `UPTRACE_DSN` environment
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
