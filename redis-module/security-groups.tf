
resource "aws_security_group" "redis_dev_legacy" {
  name_prefix = "redis_dev_legacy"
  vpc_id      = "${data.terraform_remote_state.infrastructure.outputs.vpc_id}"

  ingress {
    from_port = 6379
    to_port   = 6379
    protocol  = "tcp"

    cidr_blocks = "${concat(flatten(data.terraform_remote_state.infrastructure.outputs.subnets_cidr_persistence))}"
  }
}
