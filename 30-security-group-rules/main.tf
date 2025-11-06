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
