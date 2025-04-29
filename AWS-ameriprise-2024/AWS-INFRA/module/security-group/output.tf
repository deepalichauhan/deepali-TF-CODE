output "eks-sg"{
 value = {for k,v in aws_security_group.cluster_security_group:k=>v }
}
