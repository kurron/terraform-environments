terraform {
    required_version = ">= 0.10.7"
    backend "s3" {}
}

module "iam" {
    source = "github.com/kurron/terraform-aws-iam"

    region      = "us-east-1"
    project     = "All"
    environment = "development"
}
