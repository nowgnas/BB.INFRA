provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_sqs_queue" "card-is-register-for-order-history-queue" {
  name                      = "card-is-register-for-order-history-queue"
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 345600 # 4 days
  visibility_timeout_seconds = 40
  receive_wait_time_seconds = 10
  redrive_policy            = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
    maxReceiveCount     = 5
  })
}

resource "aws_sqs_queue" "dead_letter_queue" {
  name = "card-is-register-for-order-history-dead-letter-queue"
}
