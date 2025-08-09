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
#import bucket details
resource "aws_s3_bucket" "demobucket" {
    tags = {
      Name = "saitamademobucket"
    }
  
}
resource "aws_s3_object" "data" {
  bucket = aws_s3_bucket.demobucket.bucket
  key = "data.txt"
  source = "./data.txt"

}
