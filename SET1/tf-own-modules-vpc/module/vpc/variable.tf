variable "vpc_config" {
    description = "cidr block and name for the VPC moldule"
    type = object({
       cidr_block = string
       name = string

    })
  
}

variable "subnet_config" {
    description = "values for the subnet"
    type = map(object({
      cidr_block = string
      az = string  
      public = optional(bool, false)
    }))
  
}