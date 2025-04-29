output vpc_id {

    value = aws_vpc.VPC.id 
}




output "private-subnets_id"{

    value = {for k,v in aws_subnet.private_subnet: k=>v  }
}