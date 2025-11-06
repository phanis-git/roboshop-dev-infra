output "vpc_id" {
  value = module.vpc_test.vpc_id
}
output "public_subnet_ids" {
  value = module.vpc_test.public_subnet_ids
}
output "private_subnet_ids" {
  value = module.vpc_test.private_subnet_ids
}
output "database_subnet_ids" {
  value = module.vpc_test.database_subnet_ids
}
output "elastic_ip" {
  value = module.vpc_test.elastic_ip
}
output "aws_internet_gateway_id" {
  value = module.vpc_test.aws_internet_gateway_id
}