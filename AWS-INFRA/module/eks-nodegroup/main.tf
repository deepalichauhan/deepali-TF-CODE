resource "aws_eks_node_group" "terraform_nodegroup" {
   cluster_name = var.clustername
   node_role_arn = var.node_role_arn
   node_group_name = "GeneralPurposeAddons-byTerraform" 
   subnet_ids = [var.prisub1a, var.prisub1b, var.prisub1c]
   ami_type = "AL2_x86_64"
   capacity_type   = "ON_DEMAND"
   instance_types = ["c5a.xlarge"]
   disk_size      = "40"

   scaling_config {

     desired_size = 1
     max_size     = 2
     min_size     = 1
 }
   update_config {

    max_unavailable = 1
 }

  tags = {
    name        = "managed-by-terraform"
  }


}

