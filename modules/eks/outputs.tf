output "cluster_role_arn" {
  value = aws_iam_role.cluster.arn
  description = "ARN of the IAM Role for the EKS Cluster"
}

output "node_role_arn" {
  value = aws_iam_role.node.arn
  description = "ARN of the IAM Role for the EKS Node Pool"
}

output "cluster_name" {
  value       = aws_eks_cluster.cluster.name
  description = "The name of the ECS cluster."
}
