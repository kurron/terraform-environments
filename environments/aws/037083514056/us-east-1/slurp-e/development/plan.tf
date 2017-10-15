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

data "terraform_remote_state" "security-groups" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-east-1/all/development/compute/security-groups/terraform.tfstate"
        region = "us-east-1"
    }
}

data "terraform_remote_state" "iam" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "global/all/development/security/iam/terraform.tfstate"
        region = "us-east-1"
    }
}

variable "region" {
    type = "string"
    default = "us-east-1"
}

variable "project" {
    type = "string"
    default = "Slurp-E"
}

variable "creator" {
    type = "string"
    default = "kurron@jvmguy.com"
}

variable "environment" {
    type = "string"
    default = "development"
}

module "bastion" {
    source = "github.com/kurron/terraform-aws-bastion"

    region                      = "${var.region}"
    project                     = "${var.project}"
    creator                     = "${var.creator}"
    environment                 = "${var.environment}"
    freetext                    = "No notes at this time."
    instance_type               = "t2.nano"
    ssh_key_name                = "Bastion"
    min_size                    = "1"
    max_size                    = "2"
    cooldown                    = "60"
    health_check_grace_period   = "300"
    desired_capacity            = "1"
    scale_down_desired_capacity = "0"
    scale_down_min_size         = "0"
    scale_up_cron               = "0 7 * * MON-FRI"
    scale_down_cron             = "0 0 * * SUN-SAT"
    public_ssh_key              = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCv70t6ne08BNDf3aAQOdhe7h1NssBGPEucjKA/gL9vXpclGBqZnvOiQltKrOeOLzcbDJYDMYIJCwtoq7R/3RLOLDSi5OChhFtyjGULkIxa2dJgKXWPz04E1260CMqkKcgrQ1AaYA122zepakE7d+ysMoKSbQSVGaleZ6aFxe8DfKMzAFFra44tF5JUSMpuqwwI/bKEyehX/PDMNe/GWUTk+5c4XC6269NbaeWMivH2CiYPPBXblj6IT+QhBY5bTEFT57GmUff1sJOyhGN+9kMhlsSrXtp1A5wGiZ8nhoUduphzP3h0RNbRVA4mmI4jMnOF51uKbOvNk3Y79FSIS9Td Access to Bastion box"
    security_group_ids          = ["${data.terraform_remote_state.security-groups.bastion_id}"]
    subnet_ids                  = "${data.terraform_remote_state.vpc.public_subnet_ids}"
}

module "ec2" {
    source = "github.com/kurron/terraform-aws-ec2"

    region                      = "${var.region}"
    name                        = "Docker Host"
    project                     = "${var.project}"
    purpose                     = "Run Docker containers"
    creator                     = "${var.creator}"
    environment                 = "${var.environment}"
    freetext                    = "No notes at this time."
    ami_regexp                  = "^amzn-ami-.*-amazon-ecs-optimized$"
    ebs_optimized               = "false"
    instance_type               = "t2.nano"
    ssh_key_name                = "${module.bastion.ssh_key_name}"
    security_group_ids          = ["${data.terraform_remote_state.security-groups.ec2_id}"]
    subnet_ids                  = "${data.terraform_remote_state.vpc.public_subnet_ids}"
    instance_profile            = "${data.terraform_remote_state.iam.cross_account_ecr_pull_profile_id}"
    scheduled                   = "Yes"
    instance_limit              = "0"
}

module "ec2_park" {
    source = "github.com/kurron/terraform-aws-ec2-park"

    region                = "${var.region}"
    project               = "${var.project}"
    creator               = "${var.creator}"
    environment           = "${var.environment}"
    freetext              = "No notes at this time."
    role_arn              = "${data.terraform_remote_state.iam.ec2_park_role_arn}"
    start_cron_expression = "cron(0 7 ? * MON-FRI *)"
    stop_cron_expression  = "cron(0 0 ? * SUN-SAT *)"
}
