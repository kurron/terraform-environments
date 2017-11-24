terraform {
    required_version = ">= 0.11"
    backend "s3" {}
}

variable "region" {
    type = "string"
    default = "us-east-1"
}

variable "domain_name" {
    type = "string"
    default = "transparent.engineering"
}

provider "aws" {
    region = "${var.region}"
}

data "aws_acm_certificate" "certificate" {
    domain   = "*.${var.domain_name}"
    statuses = ["ISSUED"]
}

data "terraform_remote_state" "vpc" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-east-1/all/examples/networking/vpc/terraform.tfstate"
        region = "us-east-1"
    }
}

data "terraform_remote_state" "security-groups" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-east-1/all/examples/compute/security-groups/terraform.tfstate"
        region = "us-east-1"
    }
}

module "load_balancer" {
    source = "kurron/alb/aws"

    region             = "${var.region}"
    name               = "Load Balancer"
    project            = "All"
    purpose            = "Balances HTTP traffic between services"
    creator            = "kurr@kurron.org"
    environment        = "examples"
    freetext           = "Shared by all projects"
    internal           = "No"
    security_group_ids = ["${data.terraform_remote_state.security-groups.alb_id}"]
    subnet_ids         = "${data.terraform_remote_state.vpc.public_subnet_ids}"
    vpc_id             = "${data.terraform_remote_state.vpc.vpc_id}"
    ssl_policy         = "ELBSecurityPolicy-TLS-1-2-2017-01"
    certificate_arn    = "${data.aws_acm_certificate.certificate.arn}"
}
