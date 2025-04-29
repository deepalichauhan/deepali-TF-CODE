module "vpc"{
    source = "./module/vpc"
    cidr_block = var.cidr_block
    pubsnet = var.pubsnet
    prisub = var.prisub

}
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "availability_zone_count" {
  value = module.vpc.availability_zone_count
}



module "iam"{

  source = "./module/iam"
}

module "eks"{

  source = "./module/eks-cluster"
  cluster_name = var.cluster_name
  role_arn =module.iam.eks_role_arn
  eks_version = var.eks_version
  eks-sg = lookup(module.security-group.eks-sg,"api-server",null).id
  prisub1 = lookup(module.vpc.private-subnets_id,"privatesub-1",null).id
  prisub2 = lookup(module.vpc.private-subnets_id,"privatesub-2",null).id
  prisub3 = lookup(module.vpc.private-subnets_id,"privatesub-3",null).id
}

data "aws_eks_cluster" "tf-eks" {
  name = module.eks.ekscluster_name
}

data "aws_eks_cluster_auth" "tf-eksauth" {
  name = module.eks.ekscluster_name # Using the EKS cluster name from the data source
}





module "nodegroup"{
   
   source = "./module/eks-nodegroup"
   clustername = module.eks.ekscluster_name
   node_role_arn = module.iam.eksnode_arn
   prisub1a = lookup(module.vpc.private-subnets_id,"privatesub-1",null).id
   prisub1b = lookup(module.vpc.private-subnets_id,"privatesub-2",null).id
   prisub1c = lookup(module.vpc.private-subnets_id,"privatesub-3",null).id


}

module "security-group"{
   
   source = "./module/security-group"
   vpcid = module.vpc.vpc_id
   sg_details = {

    api-server = {
      name        = "eks-controlplane"
      description = "TF-eks-controlplane"
      ingress_rules = [
        
        {
          description = "TF-eks-controlplane"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
          security_groups = null
          self = null

        }
       
       ]
    }}
}