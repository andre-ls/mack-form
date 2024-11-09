module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  primary_subnet_cidr = "10.0.1.0/24"
  secondary_subnet_cidr = "10.0.4.0/24"
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.main_vpc_id
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
