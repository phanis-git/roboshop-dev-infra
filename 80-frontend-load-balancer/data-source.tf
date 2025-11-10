# fetching frontend sg id from ssm parameters
# "frontend","catalogue","user","cart","shipping","payment","mongodb","redis","mysql","rabbitmq","bastion","frontend-loadbalancer","backend-loadbalancer"
data "aws_ssm_parameter" "frontend" {
  name = "/${var.project_name}/${var.environment_name}/frontend"
}
data "aws_ssm_parameter" "catalogue" {
  name = "/${var.project_name}/${var.environment_name}/catalogue"
}
data "aws_ssm_parameter" "user" {
  name = "/${var.project_name}/${var.environment_name}/user"
}
data "aws_ssm_parameter" "cart" {
  name = "/${var.project_name}/${var.environment_name}/cart"
}
data "aws_ssm_parameter" "shipping" {
  name = "/${var.project_name}/${var.environment_name}/shipping"
}
data "aws_ssm_parameter" "payment" {
  name = "/${var.project_name}/${var.environment_name}/payment"
}
data "aws_ssm_parameter" "mongodb" {
  name = "/${var.project_name}/${var.environment_name}/mongodb"
}
data "aws_ssm_parameter" "redis" {
  name = "/${var.project_name}/${var.environment_name}/redis"
}
data "aws_ssm_parameter" "mysql" {
  name = "/${var.project_name}/${var.environment_name}/mysql"
}
data "aws_ssm_parameter" "rabbitmq" {
  name = "/${var.project_name}/${var.environment_name}/rabbitmq"
}
data "aws_ssm_parameter" "bastion" {
  name = "/${var.project_name}/${var.environment_name}/bastion"
}
data "aws_ssm_parameter" "frontend-loadbalancer" {
  name = "/${var.project_name}/${var.environment_name}/frontend-loadbalancer"
}
data "aws_ssm_parameter" "backend-loadbalancer" {
  name = "/${var.project_name}/${var.environment_name}/backend-loadbalancer"
}


# fetching public subnets ids for attaching to backend alb from ssm parameters

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment_name}/public_subnet_ids"
}

# fetch frontend_alb_certificate arn
data "aws_ssm_parameter" "frontend_alb_certificate_arn" {
  name = "/${var.project_name}/${var.environment_name}/frontend_alb_certificate_arn"
}



