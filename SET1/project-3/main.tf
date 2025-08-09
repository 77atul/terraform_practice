terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta3"
    }
  }
}


provider "aws" {
  # Configuration options
  region = "ap-south-1"
}


locals {
  user_data = yamldecode(file("./users.yaml")).users
}

output "user_data" {
    value = local.user_data[*].username
  
}
#crearing iam  users 
resource "aws_iam_user" "create-user" {
    for_each = toset(local.user_data[*].username)
    name = each.value

  
}
#creating password for iam users
resource "aws_iam_user_login_profile" "login" {
  for_each = aws_iam_user.create-user
  user = each.value.name
  password_length = 10
  lifecycle {
    ignore_changes = [
        password_length,
        password_reset_required,
        pgp_key,

    ]
}
}
#creating iam policies
resource "aws_iam_policy" "policy" {
    for_each = aws_iam_user.create-user
    name = "${each.value.name}-policy"
  
}
    