provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.aws_region}"
}

provider "random" {
  version = ">= 2.2"
}

terraform {
  required_version = ">= 0.12.26"
}