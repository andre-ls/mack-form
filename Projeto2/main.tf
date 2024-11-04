module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.4.0/24"
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.main_vpc_id
}

module "ec2" {
  source = "./modules/ec2"
  instance_type     = "t2.micro"
  subnet_id         = module.vpc.public_subnet_id
  security_group_ids = [module.security_groups.ec2_sg_id]
  instance_name     = "WebServer"
}

module "rds" {
  source             = "./modules/rds"
  subnet_ids        = [module.vpc.private_subnet_id]
  security_group_ids = [module.security_groups.rds_sg_id]
}

