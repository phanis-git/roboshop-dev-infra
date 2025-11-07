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

