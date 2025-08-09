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
resource "aws_s3_bucket" "webapp-bucket" {

    bucket = "saitamasbucket1"
  
}
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.webapp-bucket.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "index-html" {
    bucket = aws_s3_bucket.webapp-bucket.bucket
    source = "./index.html"
    key = "index.html"
  
}
resource "aws_s3_object" "styles-css" {
    bucket = aws_s3_bucket.webapp-bucket.bucket
    source = "./styles.css"
    key = "styles.css"
  
}
