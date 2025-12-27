resource "aws_sagemaker_domain" "default" {
  domain_name                   = var.domain_name
  auth_mode                     = "IAM"
  vpc_id                        = var.vpc_id
  subnet_ids                    = var.subnet_ids
  tag_propagation               = "ENABLED"
  app_network_access_type       = "VpcOnly"
  app_security_group_management = "Service"

  retention_policy {
    home_efs_file_system = "Delete"
  }

  default_user_settings {
    execution_role = aws_iam_role.sagemaker_execution.arn

    code_editor_app_settings {
      app_lifecycle_management {
        idle_settings {
          lifecycle_management        = "ENABLED"
          idle_timeout_in_minutes     = 60
          min_idle_timeout_in_minutes = 60
          max_idle_timeout_in_minutes = 60
        }
      }
    }
  }
}

resource "aws_sagemaker_user_profile" "default" {
  domain_id         = aws_sagemaker_domain.default.id
  user_profile_name = "${var.domain_name}-default-user"
  user_settings {
    execution_role = aws_iam_role.sagemaker_execution.arn
  }
}

resource "aws_iam_role" "sagemaker_execution" {
  name = "${var.domain_name}-sagemaker-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach managed policies for SageMaker
resource "aws_iam_role_policy_attachment" "sagemaker_full_access" {
  role       = aws_iam_role.sagemaker_execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}
