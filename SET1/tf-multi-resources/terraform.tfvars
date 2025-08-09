#for count
ec2_config = [ {
  ami =  "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
} ,{ami = "ami-0a0ad6b70e61be944"
instance_type = "t2.micro"}
]

#for for_each using map
ec2_map = {
  "amazon-linux" = {
   ami = "ami-0b0dcb5067f052a63"
   instance_type = "t2.micro"
    },
    "ubuntu" = {
     ami = "ami-0a0ad6b70e61be944"
      instance_type = "t2.micro"
    }
    }