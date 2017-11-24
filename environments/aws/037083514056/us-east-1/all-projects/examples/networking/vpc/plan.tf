terraform {
    required_version = ">= 0.11"
    backend "s3" {}
}

module "vpc" {
    source = "kurron/vpc/aws"

    region             = "us-east-1"
    name               = "Examples"
    project            = "All"
    purpose            = "Running sample workloads"
    creator            = "kurr@kurron.org"
    environment        = "examples"
    freetext           = "This VPC holds all examples resources.  No private subnets to keep costs down."
    cidr_range         = "10.10.0.0/16"
    private_subnets    = []
    public_subnets     = ["10.10.2.0/24","10.10.4.0/24","10.10.6.0/24","10.10.8.0/24","10.10.10.0/24","10.10.12.0/24"]
    populate_all_zones = "true"
}
