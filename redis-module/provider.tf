provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.aws_region}"
  version = ">= 2.0"
}

provider "random" {
  version = ">= 2.0"
}

terraform {
  required_version = ">= 0.13.0"
}
