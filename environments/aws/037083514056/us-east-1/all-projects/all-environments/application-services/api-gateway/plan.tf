terraform {
    required_version = ">= 0.11"
    backend "s3" {}
}

provider "aws" {
    region = "${var.region}"
}

variable "region" {
    type = "string"
    default = "us-east-1"
}

variable "domain_name" {
    type = "string"
    default = "transparent.engineering"
}

data "aws_acm_certificate" "certificate" {
    domain   = "*.${var.domain_name}"
    statuses = ["ISSUED"]
}

data "aws_route53_zone" "selected" {
    name         = "${var.domain_name}."
    private_zone = false
}

module "government_gateway" {
    source = "kurron/api-gateway/aws"

    region          = "${var.region}"
    api_name        = "Government APIs"
    api_description = "Proxies HTTP calls to government services"
    domain_name     = "government.transparent.engineering"
    certificate_arn = "${data.aws_acm_certificate.certificate.arn}"
    hosted_zone_id  = "${data.aws_route53_zone.selected.zone_id}"
}

module "education_gateway" {
    source = "kurron/api-gateway/aws"

    region          = "${var.region}"
    api_name        = "Education APIs"
    api_description = "Proxies HTTP calls to education services"
    domain_name     = "education.transparent.engineering"
    certificate_arn = "${data.aws_acm_certificate.certificate.arn}"
    hosted_zone_id  = "${data.aws_route53_zone.selected.zone_id}"
}

module "library_gateway" {
    source = "kurron/api-gateway/aws"

    region          = "${var.region}"
    api_name        = "Library APIs"
    api_description = "Proxies HTTP calls to library services"
    domain_name     = "library.transparent.engineering"
    certificate_arn = "${data.aws_acm_certificate.certificate.arn}"
    hosted_zone_id  = "${data.aws_route53_zone.selected.zone_id}"
}

module "shared_gateway" {
    source = "kurron/api-gateway/aws"

    region          = "${var.region}"
    api_name        = "Shared APIs"
    api_description = "Proxies HTTP calls to services that are shared between the other APIs"
    domain_name     = "shared.transparent.engineering"
    certificate_arn = "${data.aws_acm_certificate.certificate.arn}"
    hosted_zone_id  = "${data.aws_route53_zone.selected.zone_id}"
}
