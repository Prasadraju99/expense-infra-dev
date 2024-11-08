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

variable "rds_tags" {
  default = {
    component = "mysql"
  }
}

variable "zone_name" {
  default = "prasadking.xyz"
}