module "vpc"{
    source = "./module/vpc"
    cidr_block = var.cidr_block
    publicsubnet = var.publicsubnet
    privatesubnet = var.privatesubnet
    vpc_tag = var.vpc_tag
    elasticip_tag = var.elasticip_tag
    public_routetable_tag = var.public_routetable_tag
    internet_gateway_tag = var.internet_gateway_tag
    natgateway_tag = var.natgateway_tag
    private_routetable_tag = var.private_routetable_tag

}




  module "iam"{

  source = "./module/iam"
  eks_cluster_role_tag = var.eks_cluster_role_tag
  eks_workernode_role_tag = var.eks_workernode_role_tag
}

 module "eks"{

  source = "./module/eks-cluster"
  cluster_name = var.cluster_name
  cluster_role_arn  =module.iam.cluster_role_arn
  eks_version = var.eks_version
  eks-sg = lookup(module.security-group.eks-sg,"api-server",null).id
  privatesubnet1 = lookup(module.vpc.private-subnets_id,"privatesubnet1",null).id
  privatesubnet2 = lookup(module.vpc.private-subnets_id,"privatesubnet2",null).id
  privatesubnet3 = lookup(module.vpc.private-subnets_id,"privatesubnet3",null).id
}

/*data "aws_eks_cluster" "tf-eks" {
  name = module.eks.ekscluster_name
}*/

/*data "aws_eks_cluster_auth" "tf-eksauth" {
  name = module.eks.ekscluster_name # Using the EKS cluster name from the data source
}*/





 module "nodegroup"{
   
   source = "./module/eks-nodegroup"
   clustername = module.eks.ekscluster_name
   nodegroup_arn= module.iam.workernode_arn
   node_group_name = var.node_group_name
   prisub1a = lookup(module.vpc.private-subnets_id,"privatesubnet1",null).id
   prisub1b = lookup(module.vpc.private-subnets_id,"privatesubnet2",null).id
   prisub1c = lookup(module.vpc.private-subnets_id,"privatesubnet3",null).id


}

 module "security-group"{
   
   source = "./module/security-group"                         //need formating 
   vpcid = module.vpc.vpc_id
   security_group_details = {

    api-server = {
      name        = "eks-controlplane"
      description = "controlplane-ingress"
      ingress_rules = [
        
        {
          description = "controlplane-ingress-rules"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
          security_groups = null
          self = null

        }
       
       ]

    }
    
    
    }
}