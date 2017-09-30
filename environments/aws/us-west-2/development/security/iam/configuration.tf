terraform {
    backend "s3" {
        bucket = "transparent-test-terraform-state"
        key    = "us-west-2/development/security/iam/terraform.tfstate"
        region = "us-east-1"
    }
}

module "iam" {
    source = "github.com/kurron/terraform-aws-iam"

    region      = "us-west-2"

    vpc_region  = "us-east-1"
    vpc_bucket  = "transparent-test-terraform-state"
    vpc_key     = "us-west-2/development/networking/vpc/terraform.tfstate"

    project     = "Universal"
    environment = "development"
}
