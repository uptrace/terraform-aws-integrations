# Terraform AWS CloudWatch integration for Uptrace

AWS CloudWatch allows to forward metrics and logs to third-party destinations using AWS Kinesis Data
Firehose. Uptrace provides compatible HTTP endpoints to receive data from AWS CloudWatch.

This repo contains Terraform modules that can configure AWS CloudWatch to send metrics and logs to
Uptrace.

The following integrations are supported:

- [CloudWatch Metrics](modules/cloudwatch-metrics)
- [CloudWatch Logs](modules/cloudwatch-logs)

You can also [configure CloudWatch](https://uptrace.dev/get/ingest/aws-cloudwatch.html) manually
using the AWS Console.
