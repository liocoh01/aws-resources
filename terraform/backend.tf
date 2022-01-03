terraform {
  backend "s3" {
    bucket = "aws-resources-liorco"
    key = "aws_project/terraform.state"
    region = "us-east-1"
    encrypt = true
  }
}