provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAWA7AQH7HNWB6A76R"
  secret_key = "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"
}

module "my_vpc" {
  source                 = "./modules/network"
  vpc_cidr_block         = var.vpc_cidr_block
  env_prefix             = var.env_prefix
  public_subnet_cidr_block     = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  public_subnet_availability_zone      = var.public_subnet_availability_zone
  private_subnet_availability_zone     = var.private_subnet_availability_zone
}

module "my_instance" {
    source = "./modules/instances"
    ami_id = var.ami_id
    instance_type = var.instance_type
    subnet_id = module.my_vpc.public_subnet_id
    instance_name = var.instance_name
    vpc_id = module.my_vpc.vpc_id
    env_prefix = var.env_prefix
}

