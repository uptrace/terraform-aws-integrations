module "kfh" {
  source = "../kinesis-firehose"

  name = var.name

  uptrace_dsn        = var.uptrace_dsn
  uptrace_api_host   = var.uptrace_api_host
  uptrace_event_type = "logs"

  enable_lambda_transform = var.enable_lambda_transform
  lambda_transform_arn    = var.lambda_transform_arn

  http_buffering_size     = var.http_buffering_size
  http_buffering_interval = var.http_buffering_interval

  s3_failure_bucket_arn = var.s3_failure_bucket_arn
  s3_backup_mode        = var.s3_backup_mode
  s3_buffer_size        = var.s3_buffer_size
  s3_buffer_interval    = var.s3_buffer_interval
  s3_compression_format = var.s3_compression_format

  tags = var.tags
}

resource "aws_cloudwatch_log_subscription_filter" "this" {
  count           = length(var.cloudwatch_log_groups)
  name            = "${var.cloudwatch_log_groups[count.index]}-logs_subscription_filter"
  role_arn        = aws_iam_role.this.arn
  log_group_name  = var.cloudwatch_log_groups[count.index]
  filter_pattern  = var.log_subscription_filter_pattern
  destination_arn = module.kfh.kinesis_firehose_delivery_stream_arn
}
