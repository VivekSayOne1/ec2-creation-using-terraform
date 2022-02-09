 secret_key        = "z5/WTOi4dQD2mi4lGzuOn5E2NlkYM6gUVh1z/h2w"
    access_key        = "AKIA4NUOTEE4DLEB4OVT"
    ami               = "ami-0851b76e8b1bce90b"
    key_name          = "terraform"
    instance_type     = "t2.micro"
    region            =   "ap-south-1"
    availability_zone = "ap-south-1b"
    tags              = { 
      Name            ="terraform-instance"

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
}
  sg_ingress_rules_1 = {
  "HTTP" = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }
