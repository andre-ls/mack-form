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

module "sync_lambda" {
  source = "./modules/lambda"
  #api_gateway_arn = module.sync_api_gateway.api_arn
}

module "sync_api_gateway" {
  source = "./modules/api_gateway"
  api_path = "sync_api"
}

module "sync_gateway_connection" {
  source = "./modules/api_gateway_lambda_connection"
  api_gateway_id = module.sync_api_gateway.api_gateway_id 
  api_gateway_arn = module.sync_api_gateway.api_gateway_arn
  api_gateway_root_id = module.sync_api_gateway.api_gateway_root_id 
  lambda_arn = module.sync_lambda.lambda_arn
  lambda_function_name = module.sync_lambda.lambda_function_name
}

