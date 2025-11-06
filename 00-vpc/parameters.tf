resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}/${var.environment_name}/vpc_id"
  type  = "String"
  value = module.vpc_test.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project_name}/${var.environment_name}/public_subnet_ids"
  type  = "StringList"
  value = join("," , module.vpc_test.public_subnet_ids)
  
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project_name}/${var.environment_name}/private_subnet_ids"
  type  = "StringList"
  value = join("," , module.vpc_test.private_subnet_ids)
  
}

resource "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/${var.project_name}/${var.environment_name}/database_subnet_ids"
  type  = "StringList"
  value = join("," , module.vpc_test.database_subnet_ids)
  
}