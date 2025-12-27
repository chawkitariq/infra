output "sagemaker_domain_id" {
  description = "The ID of the SageMaker domain"
  value       = aws_sagemaker_domain.default.id
}

output "sagemaker_user_profile" {
  description = "The default SageMaker user profile"
  value       = aws_sagemaker_user_profile.default.user_profile_name
}
