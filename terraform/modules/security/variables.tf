variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "application_port" {
  description = "Port used by the Flask application"
  type        = number
  default     = 5000
}

variable "database_port" {
  description = "Port used by PostgreSQL"
  type        = number
  default     = 5432
}