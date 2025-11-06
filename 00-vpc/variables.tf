variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "project_name" {
  default = "roboshop"
}
variable "environment_name" {
  default = "dev"
}

# subnet
variable "public_subnet_cird" {
  default = ["10.0.1.0/24","10.0.2.0/24"]
}
variable "private_subnet_cird" {
  default = ["10.0.11.0/24","10.0.12.0/24"]
}
variable "database_subnet_cird" {
  default = ["10.0.21.0/24","10.0.22.0/24"]
}
# subnet tags
variable "public_subnet_tags" {
  default = {
    Name = "public-subnet"
  }
}
variable "private_subnet_tags" {
  default = {
    Name = "private-subnet"
  }
}
variable "database_subnet_tags" {
  default = {
    Name = "database-subnet"
  }
}
variable "is_peering" {
  type = bool
  default = true
}