# frontend accepting traffic from frontend alb 
# above we created security groups , here i am giving security group rules
# giving inbound rules to security groups 
resource "aws_security_group_rule" "frontend_accept_from_frontend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.frontend.value   # for which security group  here frontend sg id
  source_security_group_id = data.aws_ssm_parameter.frontend-loadbalancer.value    # from which security group  here frontend-load balancer or traffic source
}

# as frontend not completed , we are using bastion instaed of ec2 from frontend
# resource "aws_security_group_rule" "backend__alb_accept_from_backend_alb" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   # cidr_blocks       = [aws_vpc.example.cidr_block]
#   security_group_id = data.aws_ssm_parameter.frontend.value   # for which security group  here frontend sg id
#   source_security_group_id = data.aws_ssm_parameter.frontend-loadbalancer.value    # from which security group  here frontend-load balancer or traffic source
# }

# here backend alb is accepting from bastion 
resource "aws_security_group_rule" "backend_alb_accept_from_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.backend-loadbalancer.value   # for which security group  here frontend sg id
  source_security_group_id = data.aws_ssm_parameter.bastion.value    # from which security group  here frontend-load balancer or traffic source
}

# bastion need to accept from out laptops

resource "aws_security_group_rule" "bastion_accept_from_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.bastion.value   # for which security group  here frontend sg id
  # source_security_group_id = data.aws_ssm_parameter.bastion.value    # here i didnot give source because my laptop is not a part of aws so i will give cird block

  cidr_blocks = ["0.0.0.0/0"]
}

# mongodb accepting connection from bastion

resource "aws_security_group_rule" "mongodb_accept_from_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.mongodb.value   # for which security group  here mongodn sg id
  source_security_group_id = data.aws_ssm_parameter.bastion.value    # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# redis accepting connection from bastion

resource "aws_security_group_rule" "redis_accept_from_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.redis.value   # for which security group  here mongodn sg id
  source_security_group_id = data.aws_ssm_parameter.bastion.value    # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# rabbitmq  accepting connection from bastion
resource "aws_security_group_rule" "rabbitmq_accept_from_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.rabbitmq.value   # for which security group  here mongodn sg id
  source_security_group_id = data.aws_ssm_parameter.bastion.value    # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# mysql  accepting connection from bastion
resource "aws_security_group_rule" "mysql_accept_from_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.mysql.value   # for which security group  here mongodn sg id
  source_security_group_id = data.aws_ssm_parameter.bastion.value    # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# catalogue  accepting connection from bastion
resource "aws_security_group_rule" "catalogue_accept_from_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.catalogue.value   # for which security group  here mongodn sg id
  source_security_group_id = data.aws_ssm_parameter.bastion.value    # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# mongodn  accepting connection from catalogue
resource "aws_security_group_rule" "mongodb_accept_from_catalogue" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.mongodb.value   # for which security group  here mongodn sg id
  source_security_group_id = data.aws_ssm_parameter.catalogue.value    # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# backend catalogue target group  accepting connection from backend alb
resource "aws_security_group_rule" "catalogue_target_group_accept_from_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.catalogue.value   # for which security group  here catalogue sg id
  source_security_group_id = data.aws_ssm_parameter.backend-loadbalancer.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
}


# frontend alb acepting from public
resource "aws_security_group_rule" "frontend_alb_accept_from_public" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.frontend-loadbalancer.value   # for which security group  here frontend sg id
  # source_security_group_id = data.aws_ssm_parameter.bastion.value    # here i didnot give source because my laptop is not a part of aws so i will give cird block

  cidr_blocks = ["0.0.0.0/0"]
}