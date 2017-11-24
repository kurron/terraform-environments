output "alb_id" {
    value = "${module.load_balancer.alb_id}"
    description = "ID of the created ALB"
}

output "alb_arn" {
    value = "${module.load_balancer.alb_arn}"
    description = "ARN of the created ALB"
}

output "alb_arn_suffix" {
    value = "${module.load_balancer.alb_arn_suffix}"
    description = "The ARN suffix for use with CloudWatch Metrics."
}

output "alb_dns_name" {
    value = "${module.load_balancer.alb_dns_name}"
    description = "The DNS name of the load balancer."
}

output "alb_zone_id" {
    value = "${module.load_balancer.alb_zone_id}"
    description = "The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record)."
}

output "secure_listener_arn" {
    value = "${module.load_balancer.secure_listener_arn}"
    description = "ARN of the secure HTTP listener."
}

output "insecure_listener_arn" {
    value = "${module.load_balancer.insecure_listener_arn}"
    description = "ARN of the insecure HTTP listener."
}
