variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
  default     = "infraks"
}

variable "eks_version" {
  description = "The version of the EKS cluster"
  type        = string
  default     = "1.33"
}

variable "subnet_ids" {
  description = "List of subnet IDs where the EKS cluster will be deployed"
  type        = list(string)
}
