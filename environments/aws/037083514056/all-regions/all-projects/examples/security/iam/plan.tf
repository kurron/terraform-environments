terraform {
    required_version = ">= 0.11"
    backend "s3" {}
}

module "iam" {
    source = "kurron/iam/aws"


    region      = "us-east-1"
    project     = "All"
    environment = "examples"
}
