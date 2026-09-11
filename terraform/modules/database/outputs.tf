output "database_endpoint" {
  description = "PostgreSQL database endpoint"
  value       = aws_db_instance.postgres.address
}

output "database_port" {
  description = "PostgreSQL database port"
  value       = aws_db_instance.postgres.port
}

output "database_name" {
  description = "PostgreSQL database name"
  value       = aws_db_instance.postgres.db_name
}

output "database_instance_id" {
  description = "RDS database instance identifier"
  value       = aws_db_instance.postgres.id
}

output "master_user_secret_arn" {
  description = "ARN of the Secrets Manager secret containing database credentials"
  value       = aws_db_instance.postgres.master_user_secret[0].secret_arn
}