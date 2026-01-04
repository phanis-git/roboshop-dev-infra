# frontend accepting traffic from frontend alb 
# above we created security groups , here i am giving security group rules
# giving inbound rules to security groups 
# resource "aws_security_group_rule" "frontend_accept_from_frontend_alb" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   # cidr_blocks       = [aws_vpc.example.cidr_block]
#   security_group_id = data.aws_ssm_parameter.frontend.value   # for which security group  here frontend sg id
#   source_security_group_id = data.aws_ssm_parameter.frontend-loadbalancer.value    # from which security group  here frontend-load balancer or traffic source
# }

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

# mongodb accepting connection from user

resource "aws_security_group_rule" "mongodb_accept_from_user" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.mongodb.value   # for which security group  here mongodn sg id
  source_security_group_id = data.aws_ssm_parameter.user.value    # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# redis accepting connection from user

resource "aws_security_group_rule" "redis_accept_from_user" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.redis.value   # for which security group  here mongodn sg id
  source_security_group_id = data.aws_ssm_parameter.user.value    # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# redis accepting connection from cart

resource "aws_security_group_rule" "redis_accept_from_cart" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.redis.value   # for which security group  here mongodn sg id
  source_security_group_id = data.aws_ssm_parameter.cart.value    # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# mysql accepting connection from shipping

resource "aws_security_group_rule" "mysql_accept_from_shipping" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.mysql.value   # for which security group  here mongodn sg id
  source_security_group_id = data.aws_ssm_parameter.shipping.value    # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# rabbit accepting connection from payment

resource "aws_security_group_rule" "rabbit_accept_from_payment" {
  type              = "ingress"
  from_port         = 5672
  to_port           = 5672
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.rabbitmq.value   # for which security group  here mongodn sg id
  source_security_group_id = data.aws_ssm_parameter.payment.value    # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# backend user target group  accepting connection from backend alb
resource "aws_security_group_rule" "user_target_group_accept_from_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.user.value   # for which security group  here catalogue sg id
  source_security_group_id = data.aws_ssm_parameter.backend-loadbalancer.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# payment user target group  accepting connection from backend alb
resource "aws_security_group_rule" "payment_target_group_accept_from_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.payment.value   # for which security group  here catalogue sg id
  source_security_group_id = data.aws_ssm_parameter.backend-loadbalancer.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
}
# shipping user target group  accepting connection from backend alb
resource "aws_security_group_rule" "shipping_target_group_accept_from_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.shipping.value   # for which security group  here catalogue sg id
  source_security_group_id = data.aws_ssm_parameter.backend-loadbalancer.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# cart user target group  accepting connection from backend alb
resource "aws_security_group_rule" "cart_target_group_accept_from_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.cart.value   # for which security group  here catalogue sg id
  source_security_group_id = data.aws_ssm_parameter.backend-loadbalancer.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# catalogue  target group  accepting connection from cart
# This is the mistake , cart cannot access catalogue directly , it should be through backend ALB
# resource "aws_security_group_rule" "catalogue_target_group_accept_from_cart" {
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"
#   # cidr_blocks       = [aws_vpc.example.cidr_block]
#   security_group_id = data.aws_ssm_parameter.catalogue.value   # for which security group  here catalogue sg id
#   source_security_group_id = data.aws_ssm_parameter.cart.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
# }



# backend alb should accept connection from cart
resource "aws_security_group_rule" "backend_alb_accept_from_cart" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.backend-loadbalancer.value   # for which security group  here frontend sg id
  source_security_group_id = data.aws_ssm_parameter.cart.value    # from which security group  here frontend-load balancer or traffic source
}


# cart  target group  accepting connection from shipping
# resource "aws_security_group_rule" "cart_target_group_accept_from_shipping" {
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"
#   # cidr_blocks       = [aws_vpc.example.cidr_block]
#   security_group_id = data.aws_ssm_parameter.cart.value   # for which security group  here catalogue sg id
#   source_security_group_id = data.aws_ssm_parameter.shipping.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
# }



# backendalb accepting connection from shipping
resource "aws_security_group_rule" "backend_alb_accept_from_shipping" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.backend-loadbalancer.value   # for which security group  here frontend sg id
  source_security_group_id = data.aws_ssm_parameter.shipping.value    # from which security group  here frontend-load balancer or traffic source
}

# user  target group  accepting connection from payment
# resource "aws_security_group_rule" "user_target_group_accept_from_payment" {
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"
#   # cidr_blocks       = [aws_vpc.example.cidr_block]
#   security_group_id = data.aws_ssm_parameter.user.value   # for which security group  here catalogue sg id
#   source_security_group_id = data.aws_ssm_parameter.payment.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
# }



# backend alb should accept connection from payment
resource "aws_security_group_rule" "backend_alb_accept_from_payment" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.backend-loadbalancer.value   # for which security group  here frontend sg id
  source_security_group_id = data.aws_ssm_parameter.payment.value    # from which security group  here frontend-load balancer or traffic source
}

# cart  target group  accepting connection from payment
# resource "aws_security_group_rule" "cart_target_group_accept_from_payment" {
#   type              = "ingress"
#   from_port         = 8080
#   to_port           = 8080
#   protocol          = "tcp"
#   # cidr_blocks       = [aws_vpc.example.cidr_block]
#   security_group_id = data.aws_ssm_parameter.cart.value   # for which security group  here catalogue sg id
#   source_security_group_id = data.aws_ssm_parameter.payment.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
# }




# backend alb  target group  accepting connection from frontend instance
resource "aws_security_group_rule" "backend_alb_accept_from_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.backend-loadbalancer.value   # for which security group  here catalogue sg id
  source_security_group_id = data.aws_ssm_parameter.frontend.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# frontend instances  accepting connection from frontend alb
resource "aws_security_group_rule" "frontend_instances_accept_from_frontend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.frontend.value   # for which security group  here catalogue sg id
  source_security_group_id = data.aws_ssm_parameter.frontend-loadbalancer.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# user  accepting connection from bastion
resource "aws_security_group_rule" "user_accept_from_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.user.value   # for which security group  here catalogue sg id
  source_security_group_id = data.aws_ssm_parameter.bastion.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
}
# cart  accepting connection from bastion
resource "aws_security_group_rule" "cart_accept_from_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.cart.value   # for which security group  here catalogue sg id
  source_security_group_id = data.aws_ssm_parameter.bastion.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# shipping  accepting connection from bastion
resource "aws_security_group_rule" "shipping_accept_from_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.shipping.value   # for which security group  here catalogue sg id
  source_security_group_id = data.aws_ssm_parameter.bastion.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# payment  accepting connection from bastion
resource "aws_security_group_rule" "payment_accept_from_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.payment.value   # for which security group  here catalogue sg id
  source_security_group_id = data.aws_ssm_parameter.bastion.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
}

# frontend  accepting connection from bastion
resource "aws_security_group_rule" "frontend_accept_from_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # cidr_blocks       = [aws_vpc.example.cidr_block]
  security_group_id = data.aws_ssm_parameter.frontend.value   # for which security group  here catalogue sg id
  source_security_group_id = data.aws_ssm_parameter.bastion.value  # here i didnot give source because my laptop is not a part of aws so i will give cird block
}