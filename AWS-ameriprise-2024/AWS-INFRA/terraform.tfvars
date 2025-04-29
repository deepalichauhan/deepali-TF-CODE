cidr_block = "10.0.0.0/16"

publicsubnet = {      //cidr_blocks for public subnet
publicsubnet-1 = {
    cidr_block        = "10.0.1.0/24"
    
}
  publicsubnet-2 = {
    cidr_block        = "10.0.2.0/24"
   
  }

   publicsubnet-3 = {
    cidr_block        = "10.0.3.0/24"
    
  }

}


vpc_tag = "Solytics-Saas-production"

elasticip_tag = "saas-production_elasticip"

public_routetable_tag = "saas-production-publicRoutetable"

internet_gateway_tag = "saas-production-internetgateway"

natgateway_tag = "saas-production-natgateway"

private_routetable_tag = "saas-production-privateRoutetable"

privatesubnet = {      //cidr_blocks for private subnet
privatesubnet1 = {
    cidr_block        = "10.0.4.0/24"
    
}
 privatesubnet2 = {
    cidr_block        = "10.0.5.0/24"
   
  }

   privatesubnet3 = {
    cidr_block        = "10.0.6.0/24"
    
  }

    privatesubnet4 = {
    cidr_block        = "10.0.7.0/24"
    
  }

    privatesubnet5= {
    cidr_block        = "10.0.8.0/24"
    
  }

    privatesubnet6 = {
    cidr_block        = "10.0.9.0/24"
    
  }

}

eks_cluster_role_tag = "saas-production-eks-clusterrole"

eks_workernode_role_tag = "saas-production-nodegroup-role"

cluster_name = "solytics-saas-production"

eks_version = "1.30"

node_group_name = "GeneralPurposeADDons-SAAS-production"