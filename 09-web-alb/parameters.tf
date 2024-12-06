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

resource "aws_ssm_parameter" "web_alb_listener_arn" {
  # /expense/dev/app_alb_listener_arn
  name  = "/${var.project_name}/${var.environment}/web_alb_listener_arn"
  type  = "String"
  value = aws_lb_listener.http.arn
}



