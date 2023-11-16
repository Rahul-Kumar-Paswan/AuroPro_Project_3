resource "aws_db_subnet_group" "my_db_subnet_group" {
  name       = "${var.env_prefix}-db-subnet-group"
  subnet_ids = [
    module.my_vpc.public_subnet_id,
    module.my_vpc.private_subnet_id
    # Add more subnet IDs as needed
  ]
  tags = {
    Name = "${var.env_prefix}-db-subnet-group"
  }
}

resource "aws_db_instance" "my_db_instance" {
  identifier              = var.db_instance_identifier
  allocated_storage       = var.db_allocated_storage
  storage_type            = "gp2"
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.db_instance_class
  name                    = var.db_name
  username                = var.db_username
  password                = var.db_password
  publicly_accessible     = false
  multi_az                = var.db_multi_az
  backup_retention_period = var.db_backup_retention_period

  vpc_security_group_ids  = [aws_security_group.my_security_group.id]
  db_subnet_group_name    = aws_db_subnet_group.my_db_subnet_group.name  # Use the name attribute of the db subnet group

  parameter_group_name    = "default.mysql5.7"

  tags = {
    Name = "${var.env_prefix}-MyDBInstance"
  }
}
