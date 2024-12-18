data "aws_ssm_parameter" "frontend_sg_id" {
  # /expense/dev/frontend_sg_id
  name = "/${var.project_name}/${var.environment}/frontend_sg_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  # /expense/dev/ublic
  name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}

data "aws_ssm_parameter" "vpc_id" {
  # /expense/dev/vpc_id
  name = "/${var.project_name}/${var.environment}/vpc_id"
}

data "aws_ssm_parameter" "web_alb_listener_arn" {
  # /expense/dev/web_alb_listener_arn
  name  = "/${var.project_name}/${var.environment}/web_alb_listener_arn"
}

# Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.
data "aws_ami" "joindevops" {
  most_recent = true
  owners      = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
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