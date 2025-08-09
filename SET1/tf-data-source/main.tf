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

#security group
data "aws_security_group" "mysg" {
    tags = {
      name = "my-sg"
    }
  
}
output "fetchsg" {
    value = data.aws_security_group.mysg.id
  
}

#subnet id 
data "aws_subnet" "mysubnet" {
    filter {
      name = "vpc-id"
      values = [ data.aws_vpc.myvpc.id ]
    }
  tags = {
    Name = "private-subnet"
  }
}

#vpc id
data "aws_vpc" "myvpc" {
    tags = {
      Name = "my_vpc1"
    }
  
}
output "fetchvpc" {
    value = data.aws_vpc.myvpc.id
  
}

#ec2 instance
resource "aws_instance" "myserver" {
  ami = "ami-0b09627181c8d5778"
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.mysubnet.id
  security_groups = [data.aws_security_group.mysg.id]
 
  tags = {
    Name = "saitama-server"
  }
}
