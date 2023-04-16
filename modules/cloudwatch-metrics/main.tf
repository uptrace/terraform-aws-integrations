module "kfh" {
  source = "../kinesis-firehose"

  name = var.name

  uptrace_dsn        = var.uptrace_dsn
  uptrace_api_host   = var.uptrace_api_host
  uptrace_event_type = "metrics"

  http_buffering_size     = var.http_buffering_size
  http_buffering_interval = var.http_buffering_interval

  s3_failure_bucket_arn = var.s3_failure_bucket_arn
  s3_backup_mode        = var.s3_backup_mode
  s3_buffer_size        = var.s3_buffer_size
  s3_buffer_interval    = var.s3_buffer_interval
  s3_compression_format = var.s3_compression_format

  tags = var.tags
}

resource "aws_cloudwatch_metric_stream" "metric-stream" {
  name          = var.name
  role_arn      = aws_iam_role.this.arn
  firehose_arn  = module.kfh.kinesis_firehose_delivery_stream_arn
  output_format = "json"

  # NOTE: include and exclude filters are _mutually exclusive_, you may not have
  # both (though this is difficult to enforce in variable validation.

  dynamic "include_filter" {
    for_each = var.namespace_include_filters

    content {
      namespace = include_filter.value
    }
  }

  dynamic "exclude_filter" {
    for_each = var.namespace_exclude_filters

    content {
      namespace = exclude_filter.value
    }
  }

  tags = var.tags
}
