# creating mongodb instance
resource "aws_instance" "mongodb" {
  ami           = data.aws_ami.joinDevops.id # Replace with a valid AMI ID for your region
  instance_type = var.instance_type
  vpc_security_group_ids = [local.mongodb_sg_id] # Replace with a valid Security Group ID
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
# terraform copy paste this file to mongodb server , top side we already have connection
   provisioner "file" {
        source      = "bootstrap.sh" # Path to the file on your local machine
        destination = "/tmp/bootstrap.sh" 
   }
     provisioner "remote-exec" {
    # command = "bootstrap-hosts.sh"   # for single command
# inline for multiple commands
    inline = [ 
          "chmod +x /tmp/bootstrap.sh",
          # "sudo sh /tmp/bootstrap.sh"     # if hard coaded
          "sudo sh /tmp/bootstrap.sh mongodb"
     ]
  }
}



# Now same as redis
# creating redis instance
resource "aws_instance" "redis" {
  ami           = data.aws_ami.joinDevops.id # Replace with a valid AMI ID for your region
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_ssm_parameter.redis_sg_id.value] # Replace with a valid Security Group ID
  subnet_id     = local.database_subnet_id # Replace with a valid Subnet ID
  tags = merge(
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-redis"   # roboshop-dev-redis
    }
  )
# we can take remote exec or null provisioner
#   provisioner "remote-exec" { 
#   }
}
# Null resource  for doing remote exec
resource "terraform_data" "redis" {
  triggers_replace = [
    aws_instance.redis.id,    # here instance id change it will trigger , instance id changing means instances increasing or decreasing
  ]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    password = "DevOps321"
    host        = aws_instance.redis.private_ip  
  }
# terraform copy paste this file to redis server , top side we already have connection
   provisioner "file" {
        source      = "bootstrap.sh" # Path to the file on your local machine
        destination = "/tmp/bootstrap.sh" 
   }
     provisioner "remote-exec" {
    # command = "bootstrap-hosts.sh"
# inline for multiple commands
    inline = [ 
          "chmod +x /tmp/bootstrap.sh",
          "sudo sh /tmp/bootstrap.sh redis"
     ]
  }
}



# same for rabbitmq 
# creating rabbitmq instance
resource "aws_instance" "rabbitmq" {
  ami           = data.aws_ami.joinDevops.id # Replace with a valid AMI ID for your region
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_sg_id.value] # Replace with a valid Security Group ID
  subnet_id     = local.database_subnet_id # Replace with a valid Subnet ID
  tags = merge(
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-rabbitmq"   # roboshop-dev-rabbitmq
    }
  )
# we can take remote exec or null provisioner
#   provisioner "remote-exec" {
    
#   }
}
# Null resource  for doing remote exec
resource "terraform_data" "rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id,    # here instance id change it will trigger , instance id changing means instances increasing or decreasing
  ]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    password = "DevOps321"
    host        = aws_instance.rabbitmq.private_ip  
  }
# terraform copy paste this file to rabbitmq server , top side we already have connection
   provisioner "file" {
        source      = "bootstrap.sh" # Path to the file on your local machine
        destination = "/tmp/bootstrap.sh" 
   }
     provisioner "remote-exec" {
    # command = "bootstrap-hosts.sh"

# inline for multiple commands
    inline = [ 
          "chmod +x /tmp/bootstrap.sh",
          "sudo sh /tmp/bootstrap.sh rabbitmq"
     ]
  }
}




# same for mysql 
# creating mysql instance
resource "aws_instance" "mysql" {
  ami           = data.aws_ami.joinDevops.id # Replace with a valid AMI ID for your region
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value] # Replace with a valid Security Group ID
  subnet_id     = local.database_subnet_id # Replace with a valid Subnet ID
  iam_instance_profile = aws_iam_instance_profile.mysql.name
  
  tags = merge(
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-mysql"   # roboshop-dev-mysql
    }
  )
# we can take remote exec or null provisioner
#   provisioner "remote-exec" {
    
#   }
}

resource "aws_iam_instance_profile" "mysql" {
  name = "mysql"
  role = "EC2SSMParametersRead"
}

# Null resource  for doing remote exec
resource "terraform_data" "mysql" {
  triggers_replace = [
    aws_instance.mysql.id,    # here instance id change it will trigger , instance id changing means instances increasing or decreasing
  ]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    password = "DevOps321"
    host        = aws_instance.mysql.private_ip  
  }
# terraform copy paste this file to mysql server , top side we already have connection
   provisioner "file" {
        source      = "bootstrap.sh" # Path to the file on your local machine
        destination = "/tmp/bootstrap.sh" 
   }
     provisioner "remote-exec" {
    # command = "bootstrap-hosts.sh"

# inline for multiple commands
    inline = [ 
          "chmod +x /tmp/bootstrap.sh",
          "sudo sh /tmp/bootstrap.sh mysql dev"
     ]
  } 
}



# creating route53 records for services
resource "aws_route53_record" "mongodb" {
  zone_id = var.route53_hosted_zone_id
  name    = "mongodb-${var.environment}.${var.domain_name}"        #mongodb-dev.devops-phani.fun 
  type    = "A"
  ttl     = 1
  records = [aws_instance.mongodb.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "redis" {
  zone_id = var.route53_hosted_zone_id
  name    = "redis-${var.environment}.${var.domain_name}"        #redis-dev.devops-phani.fun 
  type    = "A"
  ttl     = 1
  records = [aws_instance.redis.private_ip]
  allow_overwrite = true
}

resource "aws_route53_record" "rabbitmq" {
  zone_id = var.route53_hosted_zone_id
  name    = "rabbitmq-${var.environment}.${var.domain_name}"        #rabbitmq-dev.devops-phani.fun 
  type    = "A"
  ttl     = 1
  records = [aws_instance.rabbitmq.private_ip]
  allow_overwrite = true
}
resource "aws_route53_record" "mysql" {
  zone_id = var.route53_hosted_zone_id
  name    = "mysql-${var.environment}.${var.domain_name}"        #mysql-dev.devops-phani.fun 
  type    = "A"
  ttl     = 1
  records = [aws_instance.mysql.private_ip]
  allow_overwrite = true
}

