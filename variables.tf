variable "vpc_cidr_block" {
    default = "10.0.0.0/16"
}

variable "env_prefix" {
    default = "dev"
}

variable "public_subnet_cidr_block" {
    default = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
    default = "10.0.2.0/24"
}

variable "public_subnet_availability_zone" {
    default = "ap-south-1a"
}

variable "private_subnet_availability_zone" {
    default = "ap-south-1b"
}

variable "my_ip" {
    default = "10.0.1.6/24"
}

variable "avail_zone" {
    default = "ap-south-1a"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "ami_id" {}
variable "instance_name" {}


# variable "image_name" {}
