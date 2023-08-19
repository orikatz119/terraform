# data "aws_availability_zones" "available" {
#   state = "available"
# }

# variable "list_of_az" {
#   default = length(data.aws_availability_zones.available.names)
#   type = number
# }

data "aws_ami" "ami_global" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-6.1-x86_64"]
  }
}
          
variable "kubeadm_build" {
  type = bool
}

variable "type_instance" {
  type = list(string)
  default = ["t2.micro", "t2.medium"]
}

variable "key_pair_name" {
  default = "Terraform-key"
}
variable "iterations" {
    type = number
    default = 3
}

variable "vpc_region" {
  type = string
}
variable "vpc_local_id" {
  type = string
}
variable "subnet_local_id" {
  type = list(string)
}
variable "alphabet" {
  type = list(string)
  default = [ "a","b","c","d","e","f","g"]
}

variable "project_ports" {
  type = list(number)
  default = [ 22, 80, 443, 5000 ]
}