output "bastion_id" {
    value = "${module.security-group.bastion_id}"
}

output "ec2_id" {
    value = "${module.security-group.ec2_id}"
}
