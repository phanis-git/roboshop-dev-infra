variable "project_name" {
  default = "roboshop"
}
variable "environment" {
  default = "dev"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "sg_names" {
  type = list 
    default = ["frontend","catalogue","user","cart","shipping","payment","mongodb","redis","mysql","rabbitmq","bastion"]
}

variable "bastion_aws_instance_tags" {
  type = map 
  default = {
    Name = "bastion"
  }
}