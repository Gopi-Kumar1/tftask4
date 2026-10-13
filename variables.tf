variable "aws_region" {
  description = "Configured the aws region."
  type        = string
}

variable "project_tag" {
  description = "Configured the Project name."
  type        = string
}

variable "name_prefix" {
  description = "Prefix used to build names of all IAM resources"
  type        = string
}

variable "bucket_name" {
  description = "Name of the existing S3 bucket the policy grants access to."
  type        = string
}


