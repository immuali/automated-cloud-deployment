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