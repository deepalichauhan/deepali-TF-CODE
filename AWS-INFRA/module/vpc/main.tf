resource "aws_vpc" "Terraform_VPC" {
  cidr_block = var.cidr_block
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "managed-by-terraform"
  }
}

data "aws_availability_zones" "available" {                  //Change it 
  state = "available" 
}

resource "aws_subnet" "public_subnet" {
  for_each =   var.pubsnet
  cidr_block = each.value["cidr_block"]
  vpc_id     = aws_vpc.Terraform_VPC.id
  availability_zone = data.aws_availability_zones.available.names[index(keys(var.pubsnet), each.key)]
  map_public_ip_on_launch = true
  tags = {
    Name = "terraform-${each.key}"
  }
}


resource "aws_subnet" "private_subnet" {
  for_each =   var.prisub
  cidr_block = each.value["cidr_block"]
  vpc_id     = aws_vpc.Terraform_VPC.id
  availability_zone = data.aws_availability_zones.available.names[index(keys(var.prisub), each.key)]
  tags = {
    Name = "terraform-${each.key}"
  }
}



resource "aws_internet_gateway" "internet_gateway" {
  vpc_id     = aws_vpc.Terraform_VPC.id
   tags = {
    Name = "terraform-igw"
  }
}


resource "aws_route_table" "pub-rt" {                  //pub-rt is public routetable
  vpc_id     = aws_vpc.Terraform_VPC.id
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
    tags = {
    Name = "terraform-publicRT"
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}


resource "aws_route_table_association" "public_routetable_association" {
  for_each = aws_subnet.public_subnet
  subnet_id     =  each.value.id
  route_table_id = aws_route_table.pub-rt.id
}

resource "aws_eip" "elasticip" {
  domain   = "vpc"
   tags = {
    Name = "terraform-elasticip"     //check count 
  }
}


resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.elasticip.id
  subnet_id     = lookup(aws_subnet.public_subnet,"pubsub-1",null).id
   tags = {
    Name = "terraform-natgateway"
  }

  depends_on = [aws_eip.elasticip]
}

resource "aws_route_table" "pri-rt" {                  //pri-rt is private routetable
  vpc_id     = aws_vpc.Terraform_VPC.id
   route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat-gw.id
  }
    tags = {
    Name = "terraform-privateRT"
  }

  depends_on = [aws_nat_gateway.nat-gw]
}


resource "aws_route_table_association" "private_routetable_association" {
  for_each = aws_subnet.private_subnet
  subnet_id     =  each.value.id
  route_table_id = aws_route_table.pri-rt.id
}