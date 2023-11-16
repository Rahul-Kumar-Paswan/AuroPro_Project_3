provider "aws" {
  region     = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
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
    public_key_path = local.current_env.public_key_path
}

module "my_database" {
    source = "./modules/database"
    # vpc_id = module.my_vpc.vpc_id
    # subnet_id = module.my_vpc.public_subnet_id
    env_prefix = local.current_env.env_prefix
    db_instance_identifier = local.current_env.db_instance_identifier
    db_allocated_storage = local.current_env.db_allocated_storage
    db_engine = local.current_env.db_engine
    db_engine_version = local.current_env.db_engine_version
    db_instance_class = local.current_env.db_instance_class
    db_name = local.current_env.db_name
    db_username = local.current_env.db_username
    db_password = local.current_env.db_password
    db_multi_az = local.current_env.db_multi_az
    db_backup_retention_period = local.current_env.db_backup_retention_period
}
