
resource "aws_security_group" "postgresql_dev_legacy" {
  name_prefix = "postgresql_eks_dev"
  vpc_id      = "${data.terraform_remote_state.infrastructure.outputs.vpc_id}"

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    cidr_blocks = "${concat(flatten(data.terraform_remote_state.infrastructure.outputs.subnets_cidr_persistence))}"
  }
}