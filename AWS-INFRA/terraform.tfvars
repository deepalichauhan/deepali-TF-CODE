cidr_block = "10.0.0.0/16"

pubsnet = {      //cidr_blocks for public subnet
pubsub-1 = {
    cidr_block        = "10.0.1.0/24"
    
}
  pubsub-2 = {
    cidr_block        = "10.0.2.0/24"
   
  }

   pubsub-3 = {
    cidr_block        = "10.0.3.0/24"
    
  }

}




prisub = {      //cidr_blocks for private subnet
privatesub-1 = {
    cidr_block        = "10.0.4.0/24"
    
}
  privatesub-2 = {
    cidr_block        = "10.0.5.0/24"
   
  }

   privatesub-3 = {
    cidr_block        = "10.0.6.0/24"
    
  }

    privatesub-4 = {
    cidr_block        = "10.0.7.0/24"
    
  }

    privatesub-5 = {
    cidr_block        = "10.0.8.0/24"
    
  }

    privatesub-6 = {
    cidr_block        = "10.0.9.0/24"
    
  }

}

cluster_name = "terraform-mrm-vault"

eks_version = "1.30"