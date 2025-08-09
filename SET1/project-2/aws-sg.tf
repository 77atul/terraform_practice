#CREATING THE SECURITY GROUP FOR EC2 INSTANCE
resource "aws_security_group" "my-sg" {
    vpc_id = aws_vpc.my_vpc1.id
    
    #inbound rules for http
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    #outbound rules
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "nginx-sg"
    }

  
}