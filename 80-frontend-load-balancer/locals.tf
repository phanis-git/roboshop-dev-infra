locals {
  common_name_suffix = "${var.project_name}-${var.environment_name}"
  common_tags = {
    Project = var.project_name
    Environment = var.environment_name
    Terraform = true
  }
  public_subnet_ids_list = split(",",data.aws_ssm_parameter.public_subnet_ids.value)

  frontend_loadbalancer_sg_id = data.aws_ssm_parameter.frontend-loadbalancer.value
  frontend_alb_certificate_arn = data.aws_ssm_parameter.frontend_alb_certificate_arn.value
}