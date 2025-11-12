# module "components_test" {
#   source = "../../terraform-roboshop-component"
#   component = var.component
#   rule_priority = var.rule_priority
# }

module "components_test" {
  for_each = var.components
  source = "git::https://github.com/phanis-git/terraform-roboshop-component.git?ref=main"
  component = each.key
  rule_priority = each.value.rule_priority
}