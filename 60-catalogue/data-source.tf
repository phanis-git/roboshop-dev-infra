# fetching ami_id from aws account
data "aws_ami" "joinDevops" {
    owners           = ["973714476881"]
    most_recent      = true
 
    filter {
        name   = "name"
        values = ["RHEL-9-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

# security group id
data "aws_ssm_parameter" "catalogue_sg_id" {
  name = "/${var.project_name}/${var.environment}/catalogue"
}
data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}

# "/${var.project_name}/${var.environment_name}/vpc_id"

# fetching vpc_id 

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "backend_alb_listener_arn" {
 name = "/${var.project_name}/${var.environment}/backend_alb_listener_arn"
}