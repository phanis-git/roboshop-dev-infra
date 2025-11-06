# Using Open source module
# for security group - catalogue 

#  module "catalogue" {
#     source = "terraform-aws-modules/security-group/aws"
#     use_name_prefix = false
#     name        = "${local.common_name_suffix}-catalogue" 
#     description = "Security group for catalogue with custom ports open within VPC, egress all traffic"
#     vpc_id      = data.aws_ssm_parameter.vpc_id.value

# } 

# Direct resource or we can build a module also
# here i am doing direct resource for security hroup creation 
resource "aws_security_group" "main" {
    for_each = toset(var.sg_names)
    name        = "${local.common_name_suffix}-${each.key}" 
    description = "${var.sg_description_catalogue}${each.key}"
    vpc_id      = local.vpc_id

# Egress is outgoing traffic which is same for all services
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

#   Ingress need to put  
  tags = merge(
    var.sg_tags,
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-${each.key}"  # roboshop-dev-catalogue 
    }
  )
}


# frontend accepting traffic from frontend alb 
# above we created security groups , here i am giving security group rules
# giving inbound rules to security groups 
# resource "aws_security_group_rule" "frontend_accept_from_frontend_alb" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   # cidr_blocks       = [aws_vpc.example.cidr_block]
#   security_group_id = aws_security_group.main["frontend"].id    # for which security group  here frontend sg id
#   source_security_group_id = aws_security_group.main["frontend-loadbalancer"].id  # from which security group  here frontend-load balancer or traffic source
# }