terraform {
    backend "s3" {
        bucket = "transparent-test-terraform-state"
        key    = "us-east-1/development/networking/vpc/terraform.tfstate"
        region = "us-east-1"
    }
}

module "vpc" {
    source = "github.com/kurron/terraform-aws-vpc"

    region          = "us-east-1"

    name            = "Development"
    project         = "Universal"
    purpose         = "Network for development workloads"
    creator         = "kurron@jvmguy.org"
    environment     = "development"
    freetext        = "All development assets should go into this VPC"

    cidr_range      = "10.20.0.0/16"
    public_subnets  = ["10.20.10.0/24", "10.20.30.0/24", "10.20.50.0/24", "10.20.70.0/24", "10.20.90.0/24", "10.20.110.0/24"]
    private_subnets = ["10.20.20.0/24", "10.20.40.0/24", "10.20.60.0/24", "10.20.80.0/24", "10.20.100.0/24", "10.20.120.0/24"]
}
