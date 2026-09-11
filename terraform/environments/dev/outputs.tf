output "vpc_id" {
  description = "ID of the project VPC"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.network.private_subnet_ids
}

output "alb_security_group_id" {
  description = "Security Group ID for the Application Load Balancer"
  value       = module.security.alb_security_group_id
}

output "ecs_security_group_id" {
  description = "Security Group ID for ECS tasks"
  value       = module.security.ecs_security_group_id
}

output "rds_security_group_id" {
  description = "Security Group ID for RDS"
  value       = module.security.rds_security_group_id
}

output "database_endpoint" {
  description = "PostgreSQL database endpoint"
  value       = module.database.database_endpoint
}

output "database_port" {
  description = "PostgreSQL database port"
  value       = module.database.database_port
}

output "database_name" {
  description = "PostgreSQL database name"
  value       = module.database.database_name
}

output "database_instance_id" {
  description = "RDS database instance identifier"
  value       = module.database.database_instance_id
}

output "master_user_secret_arn" {
  description = "Secrets Manager ARN containing database credentials"
  value       = module.database.master_user_secret_arn
}