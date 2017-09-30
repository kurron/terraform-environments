terraform {
    backend "s3" {
        bucket = "transparent-test-terraform-state"
        key    = "ca-central-1/development/security/iam/terraform.tfstate"
        region = "us-east-1"
    }
}

module "iam" {
    source = "github.com/kurron/terraform-aws-iam"

    region      = "ca-central-1"

    vpc_region  = "us-east-1"
    vpc_bucket  = "transparent-test-terraform-state"
    vpc_key     = "ca-central-1/development/networking/vpc/terraform.tfstate"

    project     = "Universal"
    environment = "development"
}
