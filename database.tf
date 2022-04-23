data "aws_secretsmanager_secret" "password" {
  name = "db-password-${random_id.default.id}"
  depends_on = [
    aws_secretsmanager_secret.password,
    aws_secretsmanager_secret_version.password
  ]
}

data "aws_secretsmanager_secret_version" "password" {
  secret_id = data.aws_secretsmanager_secret.password.id
  depends_on = [
    aws_secretsmanager_secret.password,
    aws_secretsmanager_secret_version.password
  ]
}

resource "aws_db_instance" "myDB" {
  allocated_storage       = 10
  identifier              = "rdsinstance"
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.${var.instance_type}"
  db_name                 = var.db_name
  username                = var.db_username
  password                = data.aws_secretsmanager_secret_version.password.secret_string
  parameter_group_name    = "default.mysql5.7"
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = [aws_security_group.rds-sg.id]
  publicly_accessible     = false
  backup_retention_period = 1
  #only use this if non prod
  skip_final_snapshot       = true
  final_snapshot_identifier = "rdsinstance"

  depends_on = [
    aws_secretsmanager_secret.password,
    aws_secretsmanager_secret_version.password
  ]
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.private.id, aws_subnet.private_1.id]

}

resource "aws_security_group" "rds-sg" {
  name        = "rds_security_group"
  description = "allow access from private subnet"
  vpc_id      = aws_vpc.default.id

  ingress {
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
    cidr_blocks = [aws_subnet.private.cidr_block]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

