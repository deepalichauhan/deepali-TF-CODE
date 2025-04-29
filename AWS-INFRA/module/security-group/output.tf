output "eks-sg"{
 value = {for k,v in aws_security_group.tfsg-eks:k=>v }
}