# fetch ami id
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

# fetching security group id of bastion security group through datasource
data "aws_security_group" "bastion_sg_id" {
  name = "${local.common_name}-bastion"
}

# fetching from ssm parameter store
data "aws_ssm_parameter" "bastion_sg_id" {
    name            = "/roboshop/dev/bastion"
    #   with_decryption = true # Set to true for SecureString parameters
}
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}
output "bastion_sg_id" {
  value = data.aws_security_group.bastion_sg_id.id
}
# output "bastion_sg_id_ssm_params" {
#   value = data.aws_ssm_parameter.bastion_sg_id.value
# #   sensitive = false
# }
output "ami_id" {
  value = data.aws_ami.joinDevops.image_id
}