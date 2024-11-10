module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  primary_subnet_cidr = "10.0.1.0/24"
  secondary_subnet_cidr = "10.0.4.0/24"
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.main_vpc_id
  primary_subnet_cidr = "10.0.1.0/24"
  secondary_subnet_cidr = "10.0.4.0/24"
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
}

# Async Requests
module "async_sqs" {
  source = "./modules/sqs"
  lambda_arn = module.async_lambda.lambda_arn
}

module "async_lambda" {
  source = "./modules/async_lambda"
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
}
