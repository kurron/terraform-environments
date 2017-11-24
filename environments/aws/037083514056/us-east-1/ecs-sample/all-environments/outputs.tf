output "journaler_parent_resource_id" {
    value = "${module.journaler_api_gateway_binding.parent_resource_id}"
}

output "journaler_child_resource_id" {
    value = "${module.journaler_api_gateway_binding.child_resource_id}"
}

output "journaler_parent_method_http_method" {
    value = "${module.journaler_api_gateway_binding.parent_method_http_method}"
}

output "journaler_child_method_http_method" {
    value = "${module.journaler_api_gateway_binding.child_method_http_method}"
}


output "processor_parent_resource_id" {
    value = "${module.processor_api_gateway_binding.parent_resource_id}"
}

output "processor_child_resource_id" {
    value = "${module.processor_api_gateway_binding.child_resource_id}"
}

output "processor_parent_method_http_method" {
    value = "${module.processor_api_gateway_binding.parent_method_http_method}"
}

output "processor_child_method_http_method" {
    value = "${module.processor_api_gateway_binding.child_method_http_method}"
}


output "api_server_parent_resource_id" {
    value = "${module.api_server_api_gateway_binding.parent_resource_id}"
}

output "api_server_child_resource_id" {
    value = "${module.api_server_api_gateway_binding.child_resource_id}"
}

output "api_server_parent_method_http_method" {
    value = "${module.api_server_api_gateway_binding.parent_method_http_method}"
}

output "api_server_child_method_http_method" {
    value = "${module.api_server_api_gateway_binding.child_method_http_method}"
}
