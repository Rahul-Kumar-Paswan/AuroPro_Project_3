provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}

# # Retrieve the current environment from the workspace
# locals {
#   current_env = lookup(var.environments, terraform.workspace, {})
# }

module "my_vpc" {
  source                 = "./modules/network"
  vpc_cidr_block         = local.current_env.vpc_cidr_block
  env_prefix             = local.current_env.env_prefix
  public_subnet_cidr_block     = local.current_env.public_subnet_cidr_block
  private_subnet_cidr_block = local.current_env.private_subnet_cidr_block
  public_subnet_availability_zone = local.current_env.public_subnet_availability_zone
  private_subnet_availability_zone = local.current_env.private_subnet_availability_zone
}

module "my_instance" {
    source = "./modules/instances"
    ami_id = local.current_env.ami_id
    instance_type = local.current_env.instance_type
    subnet_id = module.my_vpc.public_subnet_id
    instance_name = local.current_env.instance_name
    vpc_id = module.my_vpc.vpc_id
    env_prefix = local.current_env.env_prefix
    private_key_path = local.current_env.private_key_path
}
