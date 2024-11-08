# resource "aws_ssm_parameter" "mysql_sg_id" {
#   # /expense/dev/mysql_sg_id
#   name  = "/${var.project_name}/${var.environment}/mysql_sg_id"
#   type  = "String"
#   value = module.mysql_sg.id
# }

# resource "aws_ssm_parameter" "app_alb_sg_id" {
#   # /expense/dev/app_alb_sg_id
#   name  = "/${var.project_name}/${var.environment}/app_alb_sg_id"
#   type  = "String"
#   value = module.app_alb_sg.id
# }
