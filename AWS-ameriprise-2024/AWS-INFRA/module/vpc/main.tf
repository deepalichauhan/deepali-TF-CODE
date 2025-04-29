resource "aws_vpc" "VPC" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "var.vpc_tag"
  }
}

data "aws_availability_zones" "availability_zones" {                  
  state = "available" 
}

resource "aws_subnet" "public_subnet" {
  for_each =   var.publicsubnet
  cidr_block = each.value["cidr_block"]
  vpc_id     = aws_vpc.VPC.id
  availability_zone = data.aws_availability_zones.availability_zones.names[index(keys(var.publicsubnet), each.key)]
  map_public_ip_on_launch = true
  tags = {
    Name = "terraform-${each.key}"
  }
}


resource "aws_subnet" "private_subnet" {
  for_each =   var.privatesubnet
  cidr_block = each.value["cidr_block"]
  vpc_id     = aws_vpc.VPC.id
  availability_zone = data.aws_availability_zones.availability_zones.names[index(keys(var.privatesubnet), each.key)]
  tags = {
    Name = "terraform-${each.key}"
  }
}



resource "aws_internet_gateway" "internet_gateway" {
  vpc_id     = aws_vpc.VPC.id
   tags = {
    Name = "var.internet_gateway_tag"
  }
}

resource "aws_route_table" "public-routetable" {                  
  vpc_id     = aws_vpc.VPC.id
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
    tags = {
    Name = "var.public_routetable_tag"
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}


resource "aws_route_table_association" "public_routetable_association" {
  for_each = aws_subnet.public_subnet
  subnet_id     =  each.value.id
  route_table_id = aws_route_table.public-routetable.id
}

resource "aws_eip" "elasticip" {
  domain   = "vpc"
   tags = {
    Name = "var.elasticip_tag"     
  }
}


resource "aws_nat_gateway" "natgateway" {
  allocation_id = aws_eip.elasticip.id
  subnet_id     = lookup(aws_subnet.public_subnet,"publicsubnet-1",null).id
   tags = {
    Name = "var.natgateway_tag"
  }

  depends_on = [aws_eip.elasticip]
}

resource "aws_route_table" "private-routetable" {                  
  vpc_id     = aws_vpc.VPC.id
   route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.natgateway.id
  }
    tags = {
    Name = "var.private_routetable_tag"
  }

  depends_on = [aws_nat_gateway.natgateway]
}


resource "aws_route_table_association" "private_routetable_association" {
  for_each = aws_subnet.private_subnet
  subnet_id     =  each.value.id
  route_table_id = aws_route_table.private-routetable.id
}