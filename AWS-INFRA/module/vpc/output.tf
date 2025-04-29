output vpc_id {

    value = aws_vpc.Terraform_VPC.id 
}


output "availability_zone_count" {
  value = length(data.aws_availability_zones.available.names)
}


output "private-subnets_id"{

    value = {for k,v in aws_subnet.private_subnet: k=>v  }
}