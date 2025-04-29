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

variable "cluster_name" {}    // this is name for your eks cluster 


//variable "role_arn" {}        // this is cluster IAM role 

variable "eks_version" {}        // this is EKS cluster version 

