resource "aws_instance" "jenkins_server" { 
  ami  = var.ami
  instance_type = var.instance_type
  
  for_each = {
    SG1 = module.SG.sgid
    
    }
  key_name = var.key_name
  tags = var.tags
  subnet_id = module.vpc.subnetid
  vpc_security_group_ids = [each.value]

 
  user_data = <<-EOF
             #!/bin/bash
             sudo apt-get update && sudo apt-get upgrade -y
             sudo su - ubuntu
             sudo apt install default-jdk -y
             sudo apt-get update 
             sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
             sudo  sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
             sudo apt update
             sudo apt install jenkins -y
             sudo systemctl start jenkins
             sudo ufw allow 8080
             
             EOF

 
    
}




resource "aws_eip" "jenkins-eip" {
  vpc        = true
 

  instance = aws_instance.jenkins_server["SG1"].id
  depends_on = [module.vpc.gatewayid]

}
module "vpc" {
 source  = "./module/vpc"
 availability_zone = var.availability_zone

 }
module "SG" {
  source  = "./module1/sg"
  sg_ingress_rules = var.sg_ingress_rules
 
  a_vpc_id            =  module.vpc.vpcid
  availability_zone = var.availability_zone
   
}

