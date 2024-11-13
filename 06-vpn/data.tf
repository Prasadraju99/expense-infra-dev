# data "aws_ssm_parameter" "bastion_sg_id" {
#   # /expense/dev/bastion_sg_id
#   name = "/${var.project_name}/${var.environment}/bastion_sg_id"
# }

data "aws_ssm_parameter" "vpn_sg_id" {
  # /expense/dev/vpn_sg_id
  name = "/${var.project_name}/${var.environment}/vpn_sg_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  # /expense/dev/public_subnet_ids
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}

#Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.
data "aws_ami" "joindevops" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image-fe8020db-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}