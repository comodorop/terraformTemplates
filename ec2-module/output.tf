output "elb_security_group_id" {
  value = "${module.gitlab.elb_security_group_id}"
}

output "instances_security_group_id" {
  value = "${module.gitlab.instances_security_group_id}"
}

output "elb_id" {
  value = "${module.gitlab.elb_id}"
}

output "elb_dns_name" {
  value = "${module.gitlab.elb_dns_name}"
}
