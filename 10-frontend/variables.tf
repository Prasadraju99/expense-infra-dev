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

variable "frontend_tags" {
  default = {
    Component = "frontend"
  }
}

variable "zone_name" {
  default = "prasadking.xyz"
}