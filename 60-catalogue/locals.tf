locals {
   private_subnet_id = split("," , data.aws_ssm_parameter.private_subnet_ids.value)[0]
  common_tags = {
    Project = "roboshop"
    Environment = "dev"
    Terraform = true
  }
  common_name_suffix = "${var.project_name}-${var.environment}"
  catalogue_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value

  vpc_id = data.aws_ssm_parameter.vpc_id.value
  private_subnet_ids = data.aws_ssm_parameter.private_subnet_ids.value
}