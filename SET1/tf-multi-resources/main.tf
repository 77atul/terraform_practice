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
  project = "project-01"
}

#CREATING A VPC
resource "aws_vpc" "my_vpc1" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "${local.project}-vpc"
    }
}
  #CREATE A SUBNET
  resource "aws_subnet" "main" {
    cidr_block = "10.0.${count.index}.0/24"
    vpc_id = aws_vpc.my_vpc1.id
    count = 2

    tags = {
      Name = "${local.project}-subnet-${count.index + 1}"
    }
}
output "aws_subnet_id" {
  value = aws_subnet.main[1].id
}
#creating 4ec2 instances , 2 in each subnet 
resource "aws_instance" "main" {
  ami = var.ec2_config[count.index].ami
  instance_type = var.ec2_config[count.index].instance_type
  count = length(var.ec2_config)
  subnet_id = element(aws_subnet.main[*].id, count.index % 2)
  tags = {
    Name = "${local.project}-instance-${count.index + 1}"
  }
}

resource "aws_instance" "main" {
  for_each = var.ec2_map
  ami = each.value.ami
  instance_type = each.value.instance_type
  subnet_id = element(aws_subnet.main[*].id, index(keys(var.ec2_map), each.key) % length(aws_subnet.main) )
  tags = {
    Name = "${local.project}-instance-${each.key}"
  }
}

