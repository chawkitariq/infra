variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the cluster is deployed"
  type        = string
}

variable "lbc_version" {
  description = "AWS Load Balancer Controller version"
  type        = string
  default     = "1.14.0"
}

variable "lbc_image_tag" {
  description = "AWS Load Balancer Controller image tag"
  type        = string
  default     = "v2.14.1"
}