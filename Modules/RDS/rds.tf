resource "aws_security_group" "RDS_MySQL" {
  name        = "db_SecurityGroup"
  description = "For RDS communication"
  vpc_id      = "${var.vpc__id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["11.0.6.0/24"]
  }
}


resource "aws_db_subnet_group" "RDS_SG" {
  name       = "rdssubnet"
  subnet_ids = ["${var.privateSubnet}"]
}
resource "aws_db_instance" "Create_DB_Instance" {
  identifier             = "dbinstance"
  allocated_storage      = 10
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7.23"
  instance_class         = "db.t2.micro"
  name                   = "rampup"
  username               = "dbvane"
  password               = "dbvanessa091612175"
  parameter_group_name   = "default.mysql5.7"
  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = true
  availability_zone      = "us-east-1a"
  db_subnet_group_name   = "${aws_db_subnet_group.RDS_SG.name}"
  depends_on = ["aws_db_subnet_group.RDS_SG"]
  vpc_security_group_ids = ["${aws_security_group.RDS_MySQL.id}"]
}
