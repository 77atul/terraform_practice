terraform {
 
  backend "s3" {
    bucket = "projectnote-01"
    key = "backend.tfstate"
    region = "ap-south-1"
  }
}


resource "aws_instance" "myserver" {
    ami="ami-0b09627181c8d5778"
    instance_type = "t2.micro"
    count = "1"
    tags = {
        Name = "SampleServer"
    }
  
}