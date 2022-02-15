resource "aws_security_group" "terraform-security-gp" {
   
   name        = "Terraform-sg" 
   description = "Allow web inbound traffic"
   vpc_id = var.a_vpc_id   


  
  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks 
      description = ingress.value.description
    }
  }
egress {
  from_port  = 0
  to_port    = 0
  protocol   = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

}
resource "aws_security_group_rule" "ingress_work" {
   type            = "ingress"
   from_port       = 443
   to_port         = 443
   protocol        = "tcp"
   source_security_group_id      = aws_security_group.terraform-security-gp.id
   security_group_id = aws_security_group.terraform-security-gp.id
   description = "WORK"
 }
