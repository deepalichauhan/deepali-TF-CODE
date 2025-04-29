resource "aws_security_group" "tfsg-eks" {
  vpc_id      = var.vpcid
  for_each    = var.sg_details          
  name        = each.value["name"]
  description = each.value["description"]

  dynamic "ingress" {                             
    for_each = lookup(each.value, "ingress_rules", [])
    content {
      description      = lookup(ingress.value, "description", null)  
      from_port        = lookup(ingress.value, "from_port", null)
      to_port          = lookup(ingress.value, "to_port", null)
      protocol         = lookup(ingress.value, "protocol", null)
      cidr_blocks      = lookup(ingress.value, "cidr_blocks", null)
      security_groups  = lookup(ingress.value, "security_groups", [])
      self             = lookup(ingress.value, "self", false)  # Change to `false` if not needed
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "tf-eks-sg"
  }
}
