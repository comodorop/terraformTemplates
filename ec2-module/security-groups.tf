
resource "aws_security_group" "gitlab_dev_sg" {
  name_prefix = "gitlab_dev_sg"
  vpc_id      = "${data.terraform_remote_state.infrastructure.vpc_id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["${flatten(data.terraform_remote_state.infrastructure.subnets_cidr_persistence)}"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["${flatten(data.terraform_remote_state.infrastructure.subnets_cidr_persistence)}"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["${flatten(data.terraform_remote_state.infrastructure.subnets_cidr_persistence)}"]
  }
}
