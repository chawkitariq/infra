variable "domain_name" {
  description = "Name of the SageMaker domain"
  type        = string
  default     = "infraks"
}

variable "vpc_id" {
  description = "VPC ID for the SageMaker domain"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the SageMaker domain"
  type        = list(string)
}
