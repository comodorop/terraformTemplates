terraform {
  backend "s3" {
    bucket = "flink-environments"
    key    = "development-gitlab.tfstate"
    region = "${var.aws_region}"
    profile = "${var.aws_profile}"
  }
}

data "terraform_remote_state" "infrastructure" {
  backend = "s3"
  config {
    bucket = "flink-environments"
    key    = "development-infrastructure.tfstate"
    region = "${var.aws_region}"
    profile = "${var.aws_profile}"
  }
}

data "external" "s3_secrets" {
  program = ["aws", "s3", "cp", "s3://flink-environments/development-secrets.json", "-"]
}
