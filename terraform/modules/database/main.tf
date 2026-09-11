locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "${local.name_prefix}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-db-subnet-group"
  })
}

resource "aws_db_instance" "postgres" {
  identifier = "${local.name_prefix}-postgres"

  engine         = "postgres"
  instance_class = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = 25
  storage_type          = "gp3"
  storage_encrypted     = true

  db_name  = var.database_name
  username = var.master_username
  port     = 5432

  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_security_group_id]

  publicly_accessible = false
  multi_az             = false

  backup_retention_period = 1
  deletion_protection     = false
  skip_final_snapshot     = true

  performance_insights_enabled = false

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-postgres"
  })
}