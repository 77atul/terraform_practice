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
    #CREATE A PUBLIC SUBNET
  resource "aws_subnet" "public-subnet" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.my_vpc1.id
    tags = {
      Name = "public-subnet"
    }
}
#INTERNET GATEWAY
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc1.id
    tags = {
      Name = "my_igw"
    }
}
#ROUTING TABLE
resource "aws_route_table" "my_route" {
  vpc_id = aws_vpc.my_vpc1.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id

  }
}
resource "aws_route_table_association" "public_sub" {
  route_table_id = aws_route_table.my_route.id
  subnet_id = aws_subnet.public-subnet.id

}
resource "aws_instance" "myserver" {
  ami = "ami-0b09627181c8d5778"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public-subnet.id
  
  tags = {
    Name = "saitamainstance1"
  }
}