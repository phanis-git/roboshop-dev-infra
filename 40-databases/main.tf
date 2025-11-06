# creating mongodb instance

resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.joinDevops.id # Replace with a valid AMI ID for your region
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value] # Replace with a valid Security Group ID
  subnet_id     = local.database_subnet_id # Replace with a valid Subnet ID
  tags = merge(
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-mongodb"   # roboshop-dev-mongodb
    }
  )

# we can take remote exec or null provisioner
#   provisioner "remote-exec" {
    
#   }

}

# Null resource  for doing remote exec
resource "terraform_data" "mongodb" {
  triggers_replace = [
    aws_instance.mongodb.id,    # here instance id change it will trigger , instance id changing means instances increasing or decreasing
  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    password = "DevOps321"
    host        = aws_instance.mongodb.private_ip  
  }

  provisioner "remote-exec" {
    # command = "bootstrap-hosts.sh"

# inline for multiple commands
    inline = [ 
        "echo Hello "
     ]
  }
}