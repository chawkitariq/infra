variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
}

variable "vpc_id" {
  description = "ID of the existing VPC where resources will be created"
  type        = string
}

variable "availability_zone_a" {
  description = "Availability Zone name for AZ A (e.g. us-east-1a)"
  type        = string
}

variable "availability_zone_b" {
  description = "Availability Zone name for AZ B (e.g. us-east-1b)"
  type        = string
}
