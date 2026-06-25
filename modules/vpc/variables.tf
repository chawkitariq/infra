variable "vpc_id" {
  description = "ID of the existing VPC where resources will be created"
  type        = string
}

variable "public_subnet_cidr_blocks" {
  description = "List of CIDR blocks for public subnets; module uses the first two (index 0 and 1)"
  type        = list(string)
  default     = ["172.31.48.0/20", "172.31.64.0/20"]
}

variable "private_subnet_cidr_blocks" {
  description = "List of CIDR blocks for private subnets; module uses the first two (index 0 and 1)"
  type        = list(string)
  default     = ["172.31.80.0/20", "172.31.96.0/20"]
}

variable "enable_private_internet_access" {
  description = "Whether to create NAT gateways and default routes for private subnets"
  type        = bool
  default     = true
}
