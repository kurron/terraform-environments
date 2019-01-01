resource "aws_sqs_queue" "dlq" {
    name = "echo-dlq-${var.environment}"
    tags {
        Project     = "${var.project}"
        Purpose     = "Dead letter queue for the ${var.environment} echo Lambda"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "The Lambda will try twice to process the message then place failed ones here."
    }
    lifecycle {
        create_before_destroy = true
    }
}
