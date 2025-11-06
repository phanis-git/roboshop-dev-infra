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

#  "/${var.project_name}/${var.environment}/mongodb"
data "aws_ssm_parameter" "mongodb_sg_id" {
  name = "/${var.project_name}/${var.environment}/mongodb"
}
data "aws_ssm_parameter" "database_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/database_subnet_ids"
}