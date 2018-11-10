#
# inputs
#
variable "region" {
    type = "string"
    description = "The AWS region to deploy into, e.g. us-east-1"
}

variable "environment" {
    type = "string"
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
    region     = "${var.region}"
}
