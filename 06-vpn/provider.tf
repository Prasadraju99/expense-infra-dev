terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
  }
  backend "s3" {
    bucket         = "evp-remote-state"
    key            = "expense-dev-vpn"
    region         = "us-east-1"
    dynamodb_table = "oct-locking"
  }
}
provider "aws" {
  # Configuration options
  region = "us-east-1"
}
