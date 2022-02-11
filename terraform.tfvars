    secret_key        = ""
    access_key        = ""
    ami               = ""
    key_name          = ""
    instance_type     = "t2.micro"
    region            =   "ap-south-1"
    availability_zone = "ap-south-1b"
    tags              = { 
      Name            ="jenkins-instance"
}
sg_ingress_rules = {
  "HTTP" = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  },
  "SSH" = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }


"HTTPS" = {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
  }

"JENKINS" = {
    from_port  = 8080
    to_port    = 8080
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "JENKINS"
}
}
