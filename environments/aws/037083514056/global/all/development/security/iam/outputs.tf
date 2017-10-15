output "cross_account_ecr_pull_profile_id" {
    value = "${module.iam.cross_account_ecr_pull_profile_id}"
}

output "ec2_park_role_arn" {
    value = "${module.iam.ec2_park_role_arn}"
}
