output "government_gateway_id" {
    value = "${module.government_gateway.api_gateway_id}"
}

output "government_root_resource_id" {
    value = "${module.government_gateway.api_gateway_root_resource_id}"
}

output "education_gateway_id" {
    value = "${module.education_gateway.api_gateway_id}"
}

output "education_root_resource_id" {
    value = "${module.education_gateway.api_gateway_root_resource_id}"
}

output "library_gateway_id" {
    value = "${module.library_gateway.api_gateway_id}"
}

output "library_root_resource_id" {
    value = "${module.library_gateway.api_gateway_root_resource_id}"
}
