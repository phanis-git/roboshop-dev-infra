resource "aws_instance" "bastion" {
    ami           = data.aws_ami.joinDevops.image_id
    instance_type = var.instance_type
    # here i used ssm parameter store to fetch security group id of bastion server
    vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
    subnet_id = local.public_subnet_id

  tags = merge(
    var.bastion_aws_instance_tags,
    local.common_tags,
    {
        Name = "${local.common_name}-bastion"
    }
  )
}
