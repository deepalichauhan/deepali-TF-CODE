resource "aws_eks_node_group" "worker-nodegroup" {    //same as nodegroup name 
   cluster_name = var.clustername
   node_role_arn = var.nodegroup_arn
   node_group_name = var.node_group_name 
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
    name        = "Solytics-Saas-Production"         //var    , name & env 
  }


}

