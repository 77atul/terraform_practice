terraform {}
variable "num_list" {
  type = list(number)
  default = [ 1,2,3,4,5 ]
}
variable "person_list" {
  type = list(object({
    
    fname = string
    lname = string 
  })
  )
  default = [{ fname = "John", lname = "Doe" },
  { fname = "Jane", lname = "Smith" }]
   
}
variable "map_list" {
  type = map(number)
  default = {
    "one" = 0
    "two" = 2
    "three" = 3
  }
}

locals {
  add = 2+2
  double = [for num in var.num_list : num*3 ]
  odd = [for num in var.num_list :num if num%2 != 0]
  fname_list = [for person in var.person_list : person.fname]
  map_info = [for key, value in var.map_list : value]
}



output "result" {
  value = local.map_info
}
