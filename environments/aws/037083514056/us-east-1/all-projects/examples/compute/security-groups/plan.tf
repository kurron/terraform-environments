terraform {
    required_version = ">= 0.11"
    backend "s3" {}
}

data "terraform_remote_state" "vpc" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-east-1/all/examples/networking/vpc/terraform.tfstate"
        region = "us-east-1"
    }
}

module "security-group" {
    source = "kurron/security-groups/aws"

    region                      = "us-east-1"
    project                     = "All"
    creator                     = "kurr@kurron.org"
    environment                 = "examples"
    freetext                    = "No notes yet"
    vpc_id                      = "${data.terraform_remote_state.vpc.vpc_id}"
    bastion_ingress_cidr_blocks = ["64.222.174.146/32","98.216.147.13/32"]
    vpc_cidr                    = "${data.terraform_remote_state.vpc.cidr}"
}
