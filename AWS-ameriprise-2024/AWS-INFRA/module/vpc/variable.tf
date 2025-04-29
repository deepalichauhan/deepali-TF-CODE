variable "cidr_block" {}

variable "publicsubnet" {
  type = map(object({

    cidr_block        = string
    
  }))
}


variable "privatesubnet" {
  type = map(object({

    cidr_block        = string
    
  }))
}


variable "vpc_tag" {}

variable "elasticip_tag" {}

variable "public_routetable_tag" {}

variable "internet_gateway_tag" {}

variable "natgateway_tag" {}

variable "private_routetable_tag" {}