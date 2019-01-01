data "template_file" "permissions" {
    template = "${file("${path.module}/files/notification-policy.json.template")}"
    vars {
        // relaxed because we have a cyclic dependency graph
        queue_arn  = "arn:aws:sqs:*:*:*"
        bucket_arn = "${aws_s3_bucket.bucket.arn}"
    }
}

resource "aws_sqs_queue" "nofifications" {
    name   = "showcase-notifications-${var.environment}"
    policy = "${data.template_file.permissions.rendered}"
    tags {
        Project     = "${var.project}"
        Purpose     = "Notification queue for the ${aws_s3_bucket.bucket.bucket} bucket"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "Messages due to file changes in the bucket get dropped here."
    }
}

output "notification_arn" {
    description = "The queue's Amazon Resource Name"
    value       = "${aws_sqs_queue.nofifications.arn}"
}
