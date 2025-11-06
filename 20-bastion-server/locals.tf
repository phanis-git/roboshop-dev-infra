locals {
  common_name = "${var.project_name}-${var.environment}"

  common_tags={
    Project = "${var.project_name}"
    Environment = "${var.environment}"
    Terraform = true
  }
  public_subnet_id = split("," , data.aws_ssm_parameter.public_subnet_ids.value)[0]
}