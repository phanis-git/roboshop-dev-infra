# storing security group id's in the ssm parameter store
# No need to store but practice purpose created
resource "aws_ssm_parameter" "bastion_sg_id" {
  name  = "/${var.project_name}/${var.environment}/bastion"
  type  = "String"
  value = aws_security_group.main["bastion"].id
}
# same like for others sg 

resource "aws_ssm_parameter" "frontend_sg_id" {
  name  = "/${var.project_name}/${var.environment}/frontend"
  type  = "String"
  value = aws_security_group.main["frontend"].id
}
resource "aws_ssm_parameter" "catalogue_sg_id" {
  name  = "/${var.project_name}/${var.environment}/catalogue"
  type  = "String"
  value = aws_security_group.main["catalogue"].id
}
resource "aws_ssm_parameter" "user_sg_id" {
  name  = "/${var.project_name}/${var.environment}/user"
  type  = "String"
  value = aws_security_group.main["user"].id
}
resource "aws_ssm_parameter" "cart_sg_id" {
  name  = "/${var.project_name}/${var.environment}/cart"
  type  = "String"
  value = aws_security_group.main["cart"].id
}
resource "aws_ssm_parameter" "shipping_sg_id" {
  name  = "/${var.project_name}/${var.environment}/shipping"
  type  = "String"
  value = aws_security_group.main["shipping"].id
}
resource "aws_ssm_parameter" "payment_sg_id" {
  name  = "/${var.project_name}/${var.environment}/payment"
  type  = "String"
  value = aws_security_group.main["payment"].id
}
resource "aws_ssm_parameter" "mongodb_sg_id" {
  name  = "/${var.project_name}/${var.environment}/mongodb"
  type  = "String"
  value = aws_security_group.main["mongodb"].id
}
resource "aws_ssm_parameter" "redis_sg_id" {
  name  = "/${var.project_name}/${var.environment}/redis"
  type  = "String"
  value = aws_security_group.main["redis"].id
}
resource "aws_ssm_parameter" "mysql_sg_id" {
  name  = "/${var.project_name}/${var.environment}/mysql"
  type  = "String"
  value = aws_security_group.main["mysql"].id
}
resource "aws_ssm_parameter" "rabbitmq_sg_id" {
  name  = "/${var.project_name}/${var.environment}/rabbitmq"
  type  = "String"
  value = aws_security_group.main["rabbitmq"].id
}
resource "aws_ssm_parameter" "frontend-loadbalancer_sg_id" {
  name  = "/${var.project_name}/${var.environment}/frontend-loadbalancer"
  type  = "String"
  value = aws_security_group.main["frontend-loadbalancer"].id
}
resource "aws_ssm_parameter" "backend-loadbalancer_sg_id" {
  name  = "/${var.project_name}/${var.environment}/backend-loadbalancer"
  type  = "String"
  value = aws_security_group.main["backend-loadbalancer"].id
}
# "frontend","catalogue","user","cart","shipping","payment","mongodb","redis","mysql","rabbitmq","bastion","frontend-loadbalancer","backend-loadbalancer"