resource "aws_sqs_queue" "async_queue" {
  name                      = "async-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

#Conexão com Lambda
resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = "aws_sqs_queue.async_queue.arn"
  enabled          = true
  function_name    = var.lambda_arn
  batch_size       = 1
}
