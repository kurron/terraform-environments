resource "aws_s3_bucket" "bucket" {
    bucket        = "com-jvmguy-showcase-${var.environment}"
    acl           = "public-read"
    force_destroy = "true"
    region        = "${var.region}"
    versioning {
        enabled = false
    }
    tags {
        Name        = "com-jvmguy-showcase-${var.environment}"
        Project     = "${var.project}"
        Purpose     = "Holds sample files for the ${var.environment} environment"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "Has an event trigger wired up to it."
    }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
    bucket = "${aws_s3_bucket.bucket.id}"
    queue {
        id            = "create-nofifications-${var.environment}"
        queue_arn     = "${aws_sqs_queue.nofifications.arn}"
        events        = ["s3:ObjectCreated:*"]
        filter_suffix = ".txt"
    }
}
