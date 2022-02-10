resource "aws_instance" "new_server" { 
  ami  = var.ami
  instance_type = var.instance_type
  
  for_each = {
    SG1 = module.SG.sgid
    SG2 = module.SG.sgid1
    }
  key_name = var.key_name
  tags = var.tags
  subnet_id = module.vpc.subnetid
  vpc_security_group_ids = [each.value]

 
  user_data = <<-EOF
             #!/bin/bash
             sudo apt-get update && sudo apt-get upgrade -y
             sudo apt-get install nginx -y
             sudo systemctl enable nginx
             sudo systemctl start nginx
             sudo bash -c 'echo hello world > /var/www/html/index.html'
             EOF

 
    
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
module "SG" {
  source  = "./module1/sg"
  sg_ingress_rules = var.sg_ingress_rules
  sg_ingress_rules_1 = var.sg_ingress_rules_1
  a_vpc_id            =  module.vpc.vpcid
  availability_zone = var.availability_zone
   
}

