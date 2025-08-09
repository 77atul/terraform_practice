output "instance_public_ip" {

    description = "The pubic ip address of the EC2 instance"
    value = aws_instance.mynginx-server.public_ip
  
}
output "instance_url" {
     description = "The  url of the EC2 instance"
  value = "https://${aws_instance.mynginx-server.public_ip}"
}