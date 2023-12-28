
output "queue_url" {
  value = aws_sqs_queue.sqspetadoption.id
}

output "sns_topic_arn" {
  value = aws_sns_topic.topicpetadoption.id
}

