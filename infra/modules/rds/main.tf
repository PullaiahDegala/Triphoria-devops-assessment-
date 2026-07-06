############################################################
# RDS Security Group
############################################################

resource "aws_security_group" "rds" {

  name = "${var.environment}-rds-sg"

  description = "RDS Security Group"

  vpc_id = var.vpc_id

  ingress {

    from_port = 5432

    to_port = 5432

    protocol = "tcp"

    security_groups = [
      var.ecs_security_group_id
    ]

  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

}


############################################################
# DB Subnet Group
############################################################

resource "aws_db_subnet_group" "this" {

  name = "${var.environment}-db-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.environment}-db-subnet-group"
  }
}


############################################################
# PostgreSQL RDS
############################################################

resource "aws_db_instance" "this" {

  identifier = "${var.environment}-postgres"

  engine = "postgres"

  engine_version = "16"

  instance_class = var.db_instance_class

  allocated_storage = 20

  storage_type = "gp3"

  db_name = "appdb"

  username = "appuser"

  password = "apppass123"

  publicly_accessible = false

  skip_final_snapshot = true

  backup_retention_period = var.backup_retention_period

  deletion_protection = var.deletion_protection

  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  db_subnet_group_name = aws_db_subnet_group.this.name

  tags = {
    Name = "${var.environment}-postgres"
  }
}