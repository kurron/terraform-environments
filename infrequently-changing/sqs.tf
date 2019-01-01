resource "aws_sqs_queue" "nofifications" {
    name = "showcase-notifications-${var.environment}"
    tags {
        Project     = "${var.project}"
        Purpose     = "Notification queue for the ${aws_s3_bucket.bucket.bucket} bucket"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "Messages due to file changes in the bucket get dropped here."
    }
    lifecycle {
        create_before_destroy = true
    }
}

output "notification_arn" {
    description = "The queue's Amazon Resource Name"
    value       = "${aws_sqs_queue.nofifications.arn}"
}
