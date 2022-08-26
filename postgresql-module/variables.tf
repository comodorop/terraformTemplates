# AWS variables

variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "aws_profile" {
  description = "AWS credentials profile"
}

# Project-specific variables

variable "project" {
  description = "Value for the 'Project' tag"
}

variable "environment" {
  description = "Value for the 'Environment' tag"
}
