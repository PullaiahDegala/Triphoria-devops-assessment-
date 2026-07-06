provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "../../modules/network"

  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "alb" {
  source = "../../modules/alb"

  environment       = var.environment
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
}

module "ecs" {
  source = "../../modules/ecs"

  environment           = var.environment
  vpc_id                = module.network.vpc_id
  private_subnet_ids    = module.network.private_subnet_ids
  target_group_arn      = module.alb.target_group_arn
  alb_security_group_id = module.alb.alb_security_group_id
}

module "rds" {
  source = "../../modules/rds"

  environment           = var.environment
  vpc_id                = module.network.vpc_id
  private_subnet_ids    = module.network.private_subnet_ids
  ecs_security_group_id = module.ecs.ecs_security_group_id

  db_instance_class       = var.db_instance_class
  backup_retention_period = var.backup_retention_period
  deletion_protection     = var.deletion_protection
}