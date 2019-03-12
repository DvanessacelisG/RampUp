/*====
Variables used across all modules
======*/
locals {
  production_availability_zones = ["us-east-1a", "us-east-1b"]
}

provider "aws" {
  region = "${var.region}"
}

module "Network" {
  source              = "./Modules/Network"
  environment         = "develop"
  public_subnets_cidr = ["11.0.1.0/24", "11.0.2.0/24", "11.0.3.0/24"]
  private_subnet_cidr = ["11.0.4.0/24", "11.0.5.0/24", "11.0.6.0/24"]
  region              = "${var.region}"
  availability_zones  = "${local.production_availability_zones}"
}

module "ECS_Service" {
  source         = "./Modules/ECS"
  ECR_repository = "ecsrepo-3"
  ECS_cluster    = "Vane_cluster"
  ecs_aws_ami    = "ami-02da3a138888ced85"

  instance_type     = "t2.micro"
  ecs_key_pair_name = "DanielaCelis"
  public_subnetsp   = "${module.Network.public_subnets_id}"
  private_subnetsp  = "${module.Network.private_subnet_id}"
  vpc_name          = "${module.Network.vpc_id}"
  sg_LB             = "${module.Network.sg_lb_id}"
  port_lb           = ["80", "3030" ,"3000"]
}

module "RDS" {
  source        = "./Modules/RDS"
  vpc__id       = "${module.Network.vpc_id}"
  privateSubnet = "${module.Network.private_subnet_id}"
  publicSubnet  = "${module.Network.public_subnets_id}"
}
