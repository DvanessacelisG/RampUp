variable "public_subnets_cidr" {
  type        = "list"
  description = "The CIDR block for the public subnet"
}

variable "private_subnet_cidr" {
  type        = "list"
  description = "The CIDR block for the private subnet"
}

variable "environment" {
  description = "The environment"
}

variable "region" {
  description = "The region to launch the bastion host"
}

variable "availability_zones" {
  type        = "list"
  description = "The az that the resources will be launched"
}
