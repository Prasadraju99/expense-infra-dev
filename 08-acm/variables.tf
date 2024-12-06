variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Terraform = "true"
        Environment = "dev"
    }
}


variable "zone_name" {
    default = "prasadking.xyz"
}

variable "zone_id" {
    default = "Z01844013P3FFC9B6FQWK"
}