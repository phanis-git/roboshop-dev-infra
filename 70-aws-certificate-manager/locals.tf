locals {
  common_tags = {
    Project = "roboshop"
    Environment = "dev"
    Terraform = true
  }
  common_name_suffix = "${var.project_name}-${var.environment}"
}