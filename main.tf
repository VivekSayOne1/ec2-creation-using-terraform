esource "aws_instance" "new_server" { 
  ami  = var.ami
  instance_type = var.instance_type
  
  for_each = {
    SG1 = aws_security_group.terraform-security-gp.id
    SG2 = aws_security_group.terraform-security-gp1.id
    }
  key_name = var.key_name
  tags = var.tags
  subnet_id = module.vpc.subnetid
  vpc_security_group_ids =  [each.value]

 
  user_data = <<-EOF
             #!/bin/bash
             sudo apt-get update && sudo apt-get upgrade -y
             sudo apt-get install nginx -y
             sudo systemctl enable nginx
             sudo systemctl start nginx
             sudo bash -c 'echo hello world > /var/www/html/index.html'
             EOF

 
    
}

resource "aws_security_group" "terraform-security-gp" {
   
   name        = "Terraform-sg" 
   description = "Allow web inbound traffic"
   vpc_id = module.vpc.vpcid


  
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
tags = var.tags
}
resource "aws_security_group" "terraform-security-gp1" {
   
   name        = "Terraform-sg-1" 
   description = "Allow web inbound traffic"
   vpc_id = module.vpc.vpcid


  
  dynamic "ingress" {
    for_each = var.sg_ingress_rules_1
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
tags = var.tags
}


resource "aws_eip" "tf-eip" {
  vpc        = true
 

  instance = aws_instance.new_server["SG1"].id
  depends_on = [module.vpc.gatewayid]

}
resource "aws_eip" "tf-eip1" {
  vpc        = true
 
  instance = aws_instance.new_server["SG2"].id
  depends_on = [module.vpc.gatewayid]

}
module "vpc" {
 source  = "./module/vpc"
 availability_zone = var.availability_zone

 }
