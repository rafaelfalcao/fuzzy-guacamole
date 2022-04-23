/* resource "aws_db_instance" "default" {
  allocated_storage    = 10
  identifier           = "fuzzy-database"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  dbname                 = "sample"
  username             = "thisshouldbeasecret"
  password             = "thisshouldbeasecret"
  parameter_group_name = "default.mysql5.7"
  vpc_security_group_ids = [aws_security_group.db-sg]
} */

resource "aws_security_group" "db-sg" {
  vpc_id      = aws_vpc.default.id
  name        = "rds-llow-private-subnet-sg"
  description = "security group that allows traffic from private subnet to rds"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_subnet.private.cidr_block]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-private-subnet-sg"
  }
}
