resource "aws_s3_bucket" "main" {

    bucket = "projectnote-01"
  
}
resource "aws_s3_object" "data" {
    bucket = aws_s3_bucket.main.bucket
    source = "./data.txt"
    key = "data.txt"
  
}
