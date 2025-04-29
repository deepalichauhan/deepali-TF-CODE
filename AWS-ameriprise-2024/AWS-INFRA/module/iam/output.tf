output "cluster_role_arn" {                //eks cluster role 

    value = aws_iam_role.eks_cluster_role.arn
}

output "workernode_arn" {                   //eks workernode role

    value = aws_iam_role.eks_workernode_role.arn
}