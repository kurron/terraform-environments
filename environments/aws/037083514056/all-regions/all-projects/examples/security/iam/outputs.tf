output "docker_profile_id" {
    value = "${module.iam.docker_profile_id}"
}

output "ec2_park_role_arn" {
    value = "${module.iam.ec2_park_role_arn}"
}

output "ecs_role_id" {
    value = "${module.iam.ecs_role_id}"
    description = "ID for the ECS role"
}

output "ecs_role_arn" {
    value = "${module.iam.ecs_role_arn}"
    description = "ARN for the ECS role"
}

output "ecs_profile_id" {
    value = "${module.iam.ecs_profile_id}"
    description = "ID for the ECS profile"
}
