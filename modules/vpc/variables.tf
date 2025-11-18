########################################
# VARIABLES
########################################

variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
}

variable "vpc_id" {
  description = "ID of the existing VPC where resources will be created"
  type        = string
}

variable "cidr_blocks" {
  description = "List of CIDR blocks for subnets"
  type = object({
    public_a  : string
    public_b  : string
    private_a1 : string
    private_a2 : string
    private_b1 : string
    private_b2 : string
  })
  default = {
    public_a  = "172.31.48.0/20"
    public_b  = "172.31.64.0/20"
    private_a1 = "172.31.80.0/20"
    private_a2 = "172.31.96.0/20"
    private_b1 = "172.31.112.0/20"
    private_b2 = "172.31.128.0/20"
  }
}

variable "availability_zone_a" {
  description = "Availability Zone name for AZ A (e.g. us-east-1a)"
  type        = string
}

variable "availability_zone_b" {
  description = "Availability Zone name for AZ B (e.g. us-east-1b)"
  type        = string
}
