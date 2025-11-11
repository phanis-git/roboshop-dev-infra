module "components_test" {
  source = "../../terraform-roboshop-component"
  component = var.component
  rule_priority = var.rule_priority
}