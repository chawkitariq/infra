variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
}

variable "vpc_id" {
  description = "ID of the existing VPC where resources will be created"
  type        = string
}
