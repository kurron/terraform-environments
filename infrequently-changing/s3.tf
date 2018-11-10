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
