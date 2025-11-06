variable "project_name" {
  default = "roboshop"
}
variable "environment" {
  default = "dev"
}
variable "sg_description_catalogue" {
  default = "Creating security group for "
}

variable "sg_tags" {
  type = map 
  default = {
    Owner = "Phani"
  }
}
variable "sg_names" {
  type = list 
    default = ["frontend","catalogue","user","cart","shipping","payment","mongodb","redis","mysql","rabbitmq","bastion","frontend-loadbalancer","backend-loadbalancer"]
}
