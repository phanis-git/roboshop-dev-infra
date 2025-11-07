# creating ec2 instance
resource "aws_instance" "catalogue" {
  ami           = data.aws_ami.joinDevops.id # Replace with a valid AMI ID for your region
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_ssm_parameter.catalogue_sg_id.value] # Replace with a valid Security Group ID
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