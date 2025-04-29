output "eks_role_arn" {                //eks cluster role 

    value = aws_iam_role.eks_cluster_role.arn
}

output "eksnode_arn" {                   //eks workernode 

    value = aws_iam_role.eks_worker_role.arn
}