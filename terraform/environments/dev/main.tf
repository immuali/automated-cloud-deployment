module "network" {
  source = "../../modules/network"

  project_name         = var.project_name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "security" {
  source = "../../modules/security"

  project_name     = var.project_name
  environment      = var.environment
  vpc_id           = module.network.vpc_id
  application_port = 5000
  database_port    = 5432
}

module "database" {
  source = "../../modules/database"

  project_name          = var.project_name
  environment           = var.environment
  private_subnet_ids    = module.network.private_subnet_ids
  rds_security_group_id = module.security.rds_security_group_id

  database_name     = "appdb"
  master_username   = "appadmin"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
}