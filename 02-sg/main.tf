module "mysql_sg" {
  source       = "git::https://github.com/Prasadraju99/terraform-aws-security-group.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "mysql"
  vpc_id       = local.vpc_id
  common_tags  = var.common_tags
  sg_tags      = var.mysql_sg_tags
}

module "backend_sg" {
  source       = "git::https://github.com/Prasadraju99/terraform-aws-security-group.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "backend"
  vpc_id       = local.vpc_id
  common_tags  = var.common_tags
  sg_tags      = var.backend_sg_tags
}

module "frontend_sg" {
  source       = "git::https://github.com/Prasadraju99/terraform-aws-security-group.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "frontend"
  vpc_id       = local.vpc_id
  common_tags  = var.common_tags
  sg_tags      = var.frontend_sg_tags
}

module "bastion_sg" {
  source       = "git::https://github.com/Prasadraju99/terraform-aws-security-group.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "bastion"
  vpc_id       = local.vpc_id
  common_tags  = var.common_tags
  sg_tags      = var.bastion_sg_tags
}

module "ansible_sg" {
  source       = "git::https://github.com/Prasadraju99/terraform-aws-security-group.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "ansible"
  vpc_id       = local.vpc_id
  common_tags  = var.common_tags
  sg_tags      = var.ansible_sg_tags
}

module "app_alb_sg" {
  source       = "git::https://github.com/Prasadraju99/terraform-aws-security-group.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "app-alb"
  vpc_id       = local.vpc_id
  common_tags  = var.common_tags
  sg_tags      = var.app_alb_sg_tags
}

module "vpn_sg" {
  source       = "git::https://github.com/Prasadraju99/terraform-aws-security-group.git?ref=main"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "vpn"
  vpc_id       = local.vpc_id
  common_tags  = var.common_tags
}

# MYSQL allowing connection on 3306 from the instances attached to backend security group
resource "aws_security_group_rule" "mysql_backend" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.backend_sg.id
  security_group_id        = module.mysql_sg.id
}

# # Backend allowing connection on 8080 from the instances attached to frontend security group
# resource "aws_security_group_rule" "backend_frontend" {
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   source_security_group_id = module.frontend_sg.id
#   security_group_id        = module.backend_sg.id
# }

# # Frontend allowing connection on 80 from the instances to access by public
# resource "aws_security_group_rule" "frontend_public" {
#   type                     = "ingress"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   cidr_blocks = ["0.0.0.0/0"]
#   security_group_id        = module.frontend_sg.id
# }

# Bastion allowing connection on 22 from the instances to access by mysql
resource "aws_security_group_rule" "mysql_bastion" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id        = module.mysql_sg.id
}

# Bastion allowing connection on 22 from the instances to access by backend
resource "aws_security_group_rule" "backend_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id        = module.backend_sg.id
}

# Bastion allowing connection on 22 from the instances to access by frontend
resource "aws_security_group_rule" "frontend_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id        = module.frontend_sg.id
}

# ansible allowing connection on 22 from the instances to access by mysql
resource "aws_security_group_rule" "mysql_ansible" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.ansible_sg.id
  security_group_id        = module.mysql_sg.id
}

# ansible allowing connection on 22 from the instances to access by backend
resource "aws_security_group_rule" "backend_ansible" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.ansible_sg.id
  security_group_id        = module.backend_sg.id
}

# ansible allowing connection on 22 from the instances to access by frontend
resource "aws_security_group_rule" "frontend_ansible" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = module.ansible_sg.id
  security_group_id        = module.frontend_sg.id
}

# ansible allowing connection on 22 from the instances to access by users
resource "aws_security_group_rule" "ansible_public" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id        = module.ansible_sg.id
}

# bastion allowing connection on 22 from the instances to access by users
resource "aws_security_group_rule" "bastion_public" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id        = module.bastion_sg.id
}

# backend allowing connection on 8080 from the bastion to access by app_alb
resource "aws_security_group_rule" "backend_app_alb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.app_alb_sg.id
  security_group_id        = module.backend_sg.id
}

# app_alb allowing connection on 80 from the bastion to access by app_alb
resource "aws_security_group_rule" "app_alb_bastion" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.bastion_sg.id
  security_group_id        = module.app_alb_sg.id
}
# app_alb allowing connection on 80 from the bastion to access by app_alb
resource "aws_security_group_rule" "vpn_public" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id        = module.vpn_sg.id
}
resource "aws_security_group_rule" "vpn_443" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id        = module.vpn_sg.id
}
resource "aws_security_group_rule" "vpn_943" {
  type                     = "ingress"
  from_port                = 943
  to_port                  = 943
  protocol                 = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id        = module.vpn_sg.id
}
resource "aws_security_group_rule" "vpn_119" {
  type                     = "ingress"
  from_port                = 1194
  to_port                  = 1194
  protocol                 = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id        = module.vpn_sg.id
}
# app_alb allowing connection on 22 from the vpn to access by app_alb
resource "aws_security_group_rule" "app_alb_vpn" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.id
  security_group_id        = module.app_alb_sg.id
}
# backend allowing connection on 80 from the vpn to access by backend
resource "aws_security_group_rule" "backend_vpn_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.id
  security_group_id        = module.backend_sg.id
}
# backend allowing connection on 8080 from the vpn to access by backend
resource "aws_security_group_rule" "backend_vpn_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = module.vpn_sg.id
  security_group_id        = module.backend_sg.id
}