variable "cidr_block" {}

variable "pubsnet" {
  type = map(object({

    cidr_block        = string
    
  }))
}


variable "prisub" {
  type = map(object({

    cidr_block        = string
    
  }))
}