module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  primary_subnet_cidr = "10.0.1.0/24"
  secondary_subnet_a_cidr = "10.0.2.0/24"
  secondary_subnet_b_cidr = "10.0.4.0/24"
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.main_vpc_id
  primary_subnet_cidr = [module.vpc.primary_subnet_cidr]
  secondary_subnet_cidr = [module.vpc.secondary_subnet_a_cidr, module.vpc.secondary_subnet_b_cidr]
}

# Sync Requests
module "sync_api_gateway" {
  source = "./modules/primary_api_gateway"
  api_path = "sync_api"
  lambda_arn = module.sync_lambda.lambda_arn
}

module "sync_lambda" {
  source = "./modules/sync_lambda"
  api_gateway_arn = module.sync_api_gateway.api_arn
  lambda_subnet = module.vpc.primary_subnet_id
  lambda_security_group = module.security_groups.lambda_sg_id
}

# Async Requests
module "async_sqs" {
  source = "./modules/sqs"
  lambda_arn = module.async_lambda.lambda_arn
}

module "async_lambda" {
  source = "./modules/async_lambda"
  lambda_subnet = module.vpc.primary_subnet_id
  lambda_security_group = module.security_groups.lambda_sg_id
}

# Batch Requests
module "ecs" {
  source = "./modules/ecs"
  ecs_subnet = module.vpc.primary_subnet_id
  ecs_security_group = module.security_groups.ecs_sg_id
}

module "event_bridge" {
  source = "./modules/event_bridge"
  ecs_cluster_arn = module.ecs.ecs_cluster_arn
  ecs_task_arn = module.ecs.ecs_task_arn
  ecs_task_revision = module.ecs.ecs_task_revision
  ecs_subnet = module.vpc.primary_subnet_id
  ecs_security_group = module.security_groups.ecs_sg_id
}

# Secondary Layer
module "rds" {
  source             = "./modules/rds"
  subnet_ids        = [module.vpc.secondary_subnet_a_id, module.vpc.secondary_subnet_b_id]
  security_group_ids = [module.security_groups.rds_sg_id]
}

module "dynamo_db" {
  source = "./modules/dynamo_db"
}

module "secondary_api_gateway" {
  source = "./modules/secondary_api_gateway"
  api_path = "secondary_api"
}
