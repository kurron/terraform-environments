terraform {
    required_version = ">= 0.11"
    backend "s3" {}
}

provider "aws" {
    alias  = "east"
    region = "us-east-1"
}

provider "aws" {
    region = "${var.region}"
}

variable "region" {
    type = "string"
    default = "us-east-1"
}

data "terraform_remote_state" "api_gateway" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-east-1/all/all/application-services/api-gateway/terraform.tfstate"
        region = "us-east-1"
    }
}

module "journaler_api_gateway_binding" {
    source = "kurron/api-gateway-binding/aws"

    region                       = "${var.region}"
    api_gateway_id               = "${data.terraform_remote_state.api_gateway.government_gateway_id}"
    api_gateway_root_resource_id = "${data.terraform_remote_state.api_gateway.government_root_resource_id}"
    api_root_path                = "slurp-e-journaler"
    root_api_key_required        = "true"
    child_api_key_required       = "true"
}

module "processor_api_gateway_binding" {
    source = "kurron/api-gateway-binding/aws"

    region                       = "${var.region}"
    api_gateway_id               = "${data.terraform_remote_state.api_gateway.government_gateway_id}"
    api_gateway_root_resource_id = "${data.terraform_remote_state.api_gateway.government_root_resource_id}"
    api_root_path                = "slurp-e-processor"
    root_api_key_required        = "true"
    child_api_key_required       = "true"
}

module "api_server_api_gateway_binding" {
    source = "kurron/api-gateway-binding/aws"

    region                       = "${var.region}"
    api_gateway_id               = "${data.terraform_remote_state.api_gateway.government_gateway_id}"
    api_gateway_root_resource_id = "${data.terraform_remote_state.api_gateway.government_root_resource_id}"
    api_root_path                = "slurp-e-api"
    root_api_key_required        = "true"
    child_api_key_required       = "true"
}
