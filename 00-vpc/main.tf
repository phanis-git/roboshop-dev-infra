module "vpc_test" {
    # source = "../terraform-vpc-module"
     source = "git::https://github.com/phanis-git/terraform-vpc-module.git?ref=main"
    aws_vpc_cidr_block  = var.cidr_block
    project_name = var.project_name
    environment_name = var.environment_name

    public_subnet_cird = var.public_subnet_cird
    private_subnet_cird = var.private_subnet_cird
    database_subnet_cird = var.database_subnet_cird
    is_peering = var.is_peering
}