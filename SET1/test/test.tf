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

#CREATING A VPC
resource "aws_vpc" "my_vpc1" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "my_vpc1"
    }
}
  #CREATE A PRIVATE SUBNET
  resource "aws_subnet" "private-subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my_vpc1.id
    tags = {
      Name = "private-subnet"
    }
}


