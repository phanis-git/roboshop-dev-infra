locals {
  common_name_suffix = "${var.project_name}-${var.environment}"

  common_tags= {
    Project = var.project_name
    Environment = var.environment
    Terraform = true
  }

  vpc_id = data.aws_ssm_parameter.vpc_id.value
}