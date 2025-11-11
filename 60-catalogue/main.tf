# creating ec2 instance
resource "aws_instance" "catalogue" {
  ami           = data.aws_ami.joinDevops.id # Replace with a valid AMI ID for your region
  instance_type = var.instance_type
  vpc_security_group_ids = [local.catalogue_sg_id] # Replace with a valid Security Group ID
  subnet_id     = local.private_subnet_id # Replace with a valid Subnet ID
  tags = merge(
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-catalogue"   # roboshop-dev-catalogue
    }
  )
# we can take remote exec or null provisioner
#   provisioner "remote-exec" { 
#   }
}


# Null resource  for doing remote exec
resource "terraform_data" "catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id,    # here instance id change it will trigger , instance id changing means instances increasing or decreasing
  ]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    password = "DevOps321"
    host        = aws_instance.catalogue.private_ip  
  }
# terraform copy paste this file to catalogue server , top side we already have connection
   provisioner "file" {
        source      = "catalogue.sh" # Path to the file on your local machine
        destination = "/tmp/catalogue.sh" 
   }
     provisioner "remote-exec" {
    # command = "catalogue-hosts.sh"   # for single command
# inline for multiple commands
    inline = [ 
          "chmod +x /tmp/catalogue.sh",
          # "sudo sh /tmp/catalogue.sh"     # if hard coaded
          "sudo sh /tmp/catalogue.sh catalogue ${var.environment}"
     ]
  }
}


# Stop the instance
 resource "aws_ec2_instance_state" "catalogue" {
      instance_id = aws_instance.catalogue.id
      state       = "stopped"
      depends_on = [ terraform_data.catalogue ]
    }


# Taking ami id
resource "aws_ami_from_instance" "catalogue" {
  name               = "${local.common_name_suffix}-catalogue-ami"
  source_instance_id = aws_ec2_instance_state.catalogue.id
  depends_on = [ aws_ec2_instance_state.catalogue ]
   tags = merge(
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-catalogue-ami"   # roboshop-dev-catalogue
    }
  )
}

# creating target group
resource "aws_lb_target_group" "catalogue" {
  name     = "${local.common_name_suffix}-catalogue"     # roboshop-dev-catalogue
  port     = 8080
  protocol = "HTTP"
  vpc_id   = local.vpc_id
   deregistration_delay = 60   # we shouldnot delete immediately the instance if traffic reduce , we should wait sometime because it may serving some traffic 
  health_check {
    healthy_threshold = 2
    interval = 10
    matcher = "200-299"
    path = "/health"
    port = 8080
    protocol = "HTTP"
    timeout = 2
    unhealthy_threshold = 2
  }
 
}

# Launch template
resource "aws_launch_template" "catalogue" {
  name = "${local.common_name_suffix}-catalogue"  
  image_id = aws_ami_from_instance.catalogue.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]

  # when we run terraform apply again, a new version is created with new ami id
  update_default_version = true
  tag_specifications {
    resource_type = "instance"
    tags = merge(
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-catalogue"   # roboshop-dev-catalogue
    }
  )
  }
  tag_specifications {
    resource_type = "volume"
     tags = merge(
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-catalogue"   # roboshop-dev-catalogue
    }
  )
  }
  tags = merge(
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-catalogue"   # roboshop-dev-catalogue
    }
  )
}

# Auto scaling group

resource "aws_autoscaling_group" "catalogue" {
  name                      = "${local.common_name_suffix}-catalogue"  
  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 100
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = false
    launch_template {
    id      = aws_launch_template.catalogue.id
    version = aws_launch_template.catalogue.latest_version
    }    
  vpc_zone_identifier       = [local.private_subnet_ids]
  target_group_arns = [aws_lb_target_group.catalogue.arn]

    instance_refresh {
      strategy = "Rolling"
      preferences {
        min_healthy_percentage = 50
      }
      triggers = ["launch_template"]
    }


 dynamic "tag" {
  for_each = merge(
    local.common_tags,
    {
      Name =  "${local.common_name_suffix}-catalogue" 
    }
  )
  content {
      key                 = tag.key
    value               = tag.value
    propagate_at_launch = true
  }
  }

  timeouts {
    delete = "15m"
  }
}

resource "aws_autoscaling_policy" "catalogue" {
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  name =  "${local.common_name_suffix}-catalogue"
  policy_type            = "TargetTrackingScaling"

   target_tracking_configuration {
     predefined_metric_specification {
       predefined_metric_type = "ASGAverageCPUUtilization"
     }
     target_value = 75.0
   }
}

resource "aws_lb_listener_rule" "catalogue" {
  listener_arn = data.aws_ssm_parameter.backend_alb_listener_arn.value  # catalogue.backend-alb-dev.devops-phani.fun
  priority = 10
  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.catalogue.arn
  }
  condition {
    host_header {
      values = ["catalogue.backend-alb-${var.environment}.${var.domain_name}"]
    }
  }
}

resource "terraform_data" "catalogue_local" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]
  
  depends_on = [aws_autoscaling_policy.catalogue]
  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${aws_instance.catalogue.id}"
  }
}