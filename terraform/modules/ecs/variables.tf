variable "environment" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "ecs_security_group_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "repository_url" {
  type = string
}

variable "database_endpoint" {
  type = string
}

variable "database_name" {
  type = string
}

variable "master_user_secret_arn" {
  type = string
}