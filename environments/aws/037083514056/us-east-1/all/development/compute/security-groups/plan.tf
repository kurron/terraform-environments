terraform {
    required_version = ">= 0.10.7"
    backend "s3" {}
}

data "terraform_remote_state" "vpc" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-east-1/all/development/networking/vpc/terraform.tfstate"
        region = "us-east-1"
    }
}

module "security-group" {
    source = "github.com/kurron/terraform-aws-security-groups"

    region                      = "us-east-1"
    project                     = "All"
    creator                     = "kurron@jvmguy.com"
    environment                 = "development"
    freetext                    = "No notes at this time."
    vpc_id                      = "${data.terraform_remote_state.vpc.vpc_id}"
    bastion_ingress_cidr_blocks = ["64.222.174.146/32","98.216.147.13/32"]
}
