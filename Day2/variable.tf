variable "main_vpc_cidr" {
  default  = "192.168.0.0/16"
}

variable "publicSubnetOne" {
  type = string
  default = "192.168.1.0/24"
}

variable "publicSubnetTwo" {
  type = string
  default = "192.168.2.0/24"
}

variable "privateSubnetOne" {
  type = string
  default = "192.168.3.0/24"
}

variable "privateSubnetTwo" {
  type = string
  default = "192.168.4.0/24"
}

variable "instanceAMi" {
  type = string
  default = "ami-026b57f3c383c2eec"
}

variable "instanceKeyName" {
  type = string
  default = "ecommerce-Virgania"
}

variable "instanceType" {
  type = string
  default = "t2.micro"
}



