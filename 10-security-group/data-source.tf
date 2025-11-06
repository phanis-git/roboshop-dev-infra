data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

output "ssm_para_vpc_id" {
  value = data.aws_ssm_parameter.vpc_id.value
  sensitive = true
}
