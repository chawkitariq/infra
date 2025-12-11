output "cluster_role_arn" {
  value       = aws_iam_role.cluster.arn
  description = "ARN of the IAM Role for the EKS Cluster"
}

output "node_role_arn" {
  value       = aws_iam_role.node.arn
  description = "ARN of the IAM Role for the EKS Node Pool"
}

output "cluster_name" {
  value       = aws_eks_cluster.cluster.name
  description = "The name of the EKS cluster."
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.cluster.endpoint
  description = "The endpoint for the EKS cluster API server."
}

output "cluster_certificate_authority_data" {
  value       = aws_eks_cluster.cluster.certificate_authority[0].data
  description = "Base64 encoded certificate data required to communicate with the cluster."
  sensitive   = true
}

