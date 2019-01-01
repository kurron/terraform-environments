#
# inputs
#
variable "profile" {
    type        = "string"
    description = "The AWS CLI profile to use, e.g. showcase-production"
}

variable "region" {
    type        = "string"
    description = "The AWS region to deploy into, e.g. us-east-1"
}

variable "environment" {
    type        = "string"
    description = "Context these resources will be used in, e.g. production"
}

#
# constants
#
variable "creator" {
    type        = "string"
    description = "Person or tool creating these resources, e.g. operations@example.com"
    default     = "Terraform"
}

variable "project" {
    type        = "string"
    description = "Name of the project these resources are being created for, e.g. violet-sloth"
    default     = "Weapon-X"
}

variable "terraform_state_bucket" {
    type        = "string"
    description = "Name of the bucket that holds the shared Terraform state."
    default     = "com-jvmguy-terraform-state"
}

variable "terraform_state_bucket_region" {
    type        = "string"
    description = "Region that holds the shared Terraform state."
    default     = "us-east-1"
}

#
# Terraform version check
#
terraform {
    required_version = ">= 0.11.10"
    backend "s3" {}
}

#
# AWS setup
#
provider "aws" {
    region  = "${var.region}"
    profile = "${var.profile}"
}

data "aws_caller_identity" "current" {}

data "terraform_remote_state" "stable" {
    backend = "s3"
    config {
        profile = "${var.profile}"
        bucket  = "${var.terraform_state_bucket}"
        key     = "infrequently-changing/terraform.tfstate"
        region  = "${var.terraform_state_bucket_region}"
    }
}