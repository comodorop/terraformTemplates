data "aws_ami" "gitlab" {
  most_recent = true

  filter {
    name   = "name"
    values = ["gitlab-aws-clustering-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["646771319519"]
}

resource "aws_iam_role" "gitlab" {
  name = "${var.project}-${var.environment_old}-gitlab"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "gitlab" {
  name_prefix = "${var.project}-${var.environment_old}-gitlab"
  role        = "${aws_iam_role.gitlab.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:DescribeAutoScalingInstances",
        "ec2:DescribeInstances"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "gitlab" {
  name_prefix = "${var.project}-${var.environment_old}-gitlab"
  role        = "${aws_iam_role.gitlab.name}"
}

module "gitlab" {
  source = "git::ssh://git@gitlab.fintonic.com/fintonic-ops/terraform/fintonic-aws-ec2-gitlab.git?ref=v1.8.0"

  name                           = "${var.project}-${var.environment_old}-gitlab"
  key_name                       = "${data.terraform_remote_state.infrastructure.key_name}"
  ami                            = "${data.aws_ami.gitlab.id}"
  vpc_id                         = "${data.terraform_remote_state.infrastructure.vpc_id}"
  elb_subnets                    = "${data.terraform_remote_state.infrastructure.subnets_id_persistence}"
  elb_allowed_cidrs              = "${concat(data.terraform_remote_state.infrastructure.subnets_cidr_private)}"
  elb_security_group_ids         = ["${data.terraform_remote_state.infrastructure.secgroup_id_default}"]
  instances_security_group_ids   = ["${data.terraform_remote_state.infrastructure.secgroup_id_default}"]
  instances_subnet_ids           = "${data.terraform_remote_state.infrastructure.subnets_id_persistence}"
  instances_type                 = "t2.medium"
  iam_instance_profile           = "${aws_iam_instance_profile.gitlab.name}"
  gitlab_erlang_cookie         = "${data.external.s3_secrets.result.gitlab_erlang_cookie}"

  asg_health_check_type = "ELB"
  asg_desired_capacity  = 1
  asg_min_size          = 1
  asg_max_size          = 1

  tags = {
    Platform    = "${var.project}"
    environment_old = "${var.environment_old}"
    Service     = "gitlab"
  }
}
