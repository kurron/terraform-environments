terraform {
    required_version = ">= 0.10.7"
    backend "s3" {}
}

module "vpc" {
    source = "github.com/kurron/terraform-aws-vpc"

    region             = "us-east-1"
    name               = "Development"
    project            = "All"
    purpose            = "Running development workloads"
    creator            = "kurron@jvmguy.com"
    environment        = "development"
    freetext           = "This VPC holds all development resources."
    cidr_range         = "10.10.0.0/16"
    private_subnets    = []
    public_subnets     = ["10.10.2.0/24","10.10.4.0/24","10.10.6.0/24","10.10.8.0/24","10.10.10.0/24","10.10.12.0/24"]
    populate_all_zones = "true"
}
