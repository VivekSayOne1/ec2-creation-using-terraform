resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "admin"
  password             = "Admin1234"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids = [var.security-groupid]
  db_subnet_group_name = aws_db_subnet_group.rds-subnet-group.name
}


resource "aws_db_subnet_group" "rds-subnet-group" {
  name        = "rds-subnet-group"
  description = "Terraform example RDS subnet group"
  subnet_ids  = [var.subnetid,var.subnetid2]
}
