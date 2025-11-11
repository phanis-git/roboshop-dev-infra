resource "aws_lb" "backend_alb" {
  name               = "${local.common_name_suffix}-backend-alb"  # roboshop-dev-backend-alb
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend-loadbalancer_sg_id]
  subnets            = local.private_subnet_ids_list

  enable_deletion_protection = false # prevents accidental deletion   so we need to delete from aws console by enable protection mode if true


  tags = merge(
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-backend-alb"
    }
  )
}
# backend alb listening port number 80
resource "aws_lb_listener" "backend_alb" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

#   default_action {
#     type = "redirect"

#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }


default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Hi I am from backend alb http "
      status_code  = "200"
    }
  }
}

resource "aws_route53_record" "backend_alb" {
  zone_id = var.route53_hosted_zone_id
  name = "*.backend-alb-${var.environment_name}.${var.domain_name}"
  type =  "A"
  alias {
    # These are ALB details not our domain details
    name =  aws_lb.backend_alb.dns_name
    zone_id =  aws_lb.backend_alb.zone_id
    evaluate_target_health = true
  }
}