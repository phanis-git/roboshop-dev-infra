resource "aws_instance" "bastion" {
    ami           = data.aws_ami.joinDevops.image_id
    instance_type = var.instance_type
    # here i used ssm parameter store to fetch security group id of bastion server
    vpc_security_group_ids = [data.aws_ssm_parameter.bastion_sg_id.value]
    subnet_id = local.public_subnet_id
    iam_instance_profile = aws_iam_instance_profile.bastion.name
  tags = merge(
    var.bastion_aws_instance_tags,
    local.common_tags,
    {
        Name = "${local.common_name}-bastion"
    }
  )
  # adding memory
  root_block_device {
    volume_size = 50
    volume_type = "gp3" # or gp2 depending on performance
  }
  user_data = file("bastion.sh")
}

# BastionTerraformAdmin 

resource "aws_iam_instance_profile" "bastion" {
  name = "bastion"
  role = "BastionTerraformAdmin"
}