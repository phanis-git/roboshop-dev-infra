locals {
   private_subnet_id = split("," , data.aws_ssm_parameter.private_subnet_ids.value)[0]
  common_tags = {
    Project = "roboshop"
    Environment = "dev"
    Terraform = true
  }
  common_name_suffix = "${var.project_name}-${var.environment}"
}