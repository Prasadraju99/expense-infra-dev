variable "project_name" {
  default = "expense"
}

# calling all the varaibles from module
variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project     = "Expense"
    Terraform   = "True"
    Environment = "Dev"
  }
}

variable "zone_name" {
  default = "prasadking.xyz"
}

variable "app_alb_tags" {
  default = {
    component = "app-alb"
  }
}