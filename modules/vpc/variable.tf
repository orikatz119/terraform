variable "counter_resources" {
    type = number
    default = 3
}

variable "order_alphabet" {
    default = [ "a","b","c","d","e","f","g"]
    type = list(string)
}

variable "vpc_region" {
  type = string
}

variable "cider_subnets" {
    type = list(string)
    default = [ "10","20","30" ]
}