resource "aws_eks_cluster" "terraform-eks" {
  name     = var.cluster_name
  role_arn = var.role_arn     //change it to eks_role-arn
  version  = var.eks_version

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager"
  ]

  vpc_config {
    subnet_ids              = [var.prisub1, var.prisub2, var.prisub3]
    endpoint_private_access = true
    endpoint_public_access    = false
    security_group_ids = [var.eks-sg]
  }

  access_config {
    authentication_mode                         = "CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  kubernetes_network_config {
    ip_family         = "ipv4"
    service_ipv4_cidr = "10.96.0.0/12"
  }
}

// Addons for EKS cluster
resource "aws_eks_addon" "vpc-cni" {
  cluster_name = aws_eks_cluster.terraform-eks.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.terraform-eks.name
  addon_name   = "coredns"
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name = aws_eks_cluster.terraform-eks.name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "ebs-csi-driver" {
  cluster_name = aws_eks_cluster.terraform-eks.name     //change it to efs driver
  addon_name   = "aws-ebs-csi-driver"
}

resource "aws_eks_addon" "efs_csi_driver" {
  cluster_name = aws_eks_cluster.terraform-eks.name  
  addon_name   = "aws-efs-csi-driver"
}