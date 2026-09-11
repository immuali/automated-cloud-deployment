variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs of private subnets for the database"
  type        = list(string)
}

variable "rds_security_group_id" {
  description = "Security Group ID assigned to RDS"
  type        = string
}

variable "database_name" {
  description = "Initial PostgreSQL database name"
  type        = string
  default     = "appdb"
}

variable "master_username" {
  description = "PostgreSQL administrator username"
  type        = string
  default     = "appadmin"
}

variable "instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Initial database storage in GB"
  type        = number
  default     = 20
}