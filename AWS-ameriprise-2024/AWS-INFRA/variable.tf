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

variable "eks_cluster_role_tag" {}

variable  "eks_workernode_role_tag" {}

variable "cluster_name" {}    // this is name for your eks cluster 


//variable "cluster_role_arn" {}        // this is cluster IAM role 

variable "eks_version" {}        // this is EKS cluster version 

variable "node_group_name" {}
