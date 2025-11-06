# output "sg_id" {
#   # value = aws_security_group.main[*].id
#   # value = { for name , sg in aws_aws_security_group.main : name => main.id} 
#   # value = aws_security_group.main[each.key]
#   # sensitive = true
# }
output "catalogue_sg_id" {
  value = aws_security_group.main["catalogue"].id
}
output "frontend_sg_id" {
  value = aws_security_group.main["frontend"].id
}
output "user_sg_id" {
  value = aws_security_group.main["user"].id
}
output "cart_sg_id" {
  value = aws_security_group.main["cart"].id
}
output "shipping_sg_id" {
  value = aws_security_group.main["shipping"].id
}
output "payment_sg_id" {
  value = aws_security_group.main["payment"].id
}
output "mongodb_sg_id" {
  value = aws_security_group.main["mongodb"].id
}
output "redis_sg_id" {
  value = aws_security_group.main["redis"].id
}
output "mysql_sg_id" {
  value = aws_security_group.main["mysql"].id
}
output "rabbitmq_sg_id" {
  value = aws_security_group.main["rabbitmq"].id
}
output "bastion_sg_id" {
  value = aws_security_group.main["bastion"].id
}
output "frontend-loadbalancer_sg_id" {
  value = aws_security_group.main["frontend-loadbalancer"].id
}