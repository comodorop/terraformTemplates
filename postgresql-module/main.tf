module "development_db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "3.4.0"

  name              = "gitlab-development-db"
  instance_class    = "db.t3.micro"
  allocated_storage = 10
  engine_version    = "12.6"
  family            = "postgres12"

  vpc_id             = "${data.terraform_remote_state.infrastructure.outputs.vpc_id}"
  security_group_ids = ["${data.terraform_remote_state.infrastructure.outputs.secgroup_id_default}"]
  subnet_ids         = "${data.terraform_remote_state.infrastructure.outputs.subnets_id_persistence}"
  allowed_cidrs      = "${concat(data.terraform_remote_state.infrastructure.outputs.subnets_cidr_private)}"

  username = "root"
  password = "${data.external.s3_secrets.result.rds_keycloak_root_password}"

  backup_retention_period = 4

  tags = {
    Platform        = "${var.project}"
    Environment     = "development"
    Instrumentation = "Datadog"
  }
}

output "development_db_endpoint" {
  description = "The connection endpoint"
  value       = "${module.development_db.this_db_endpoint}"
}
