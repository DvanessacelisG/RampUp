variable "ECR_repository" {
  description = "ECR_repository"
}

variable "ECS_cluster" {
  description = "ECS_cluster"
}

variable "ecs_aws_ami" {
  description = "ami to EC2 instance"
}

variable "instance_type" {}

variable "ecs_key_pair_name" {
  description = "ECS key pair name"
}

variable "public_subnetsp" {
  description = "Desired number of instances in the cluster"
  type        = "list"
}

variable "private_subnetsp" {
  description = "Desired number of instances in the cluster"
  type        = "list"
}

variable "vpc_name" {}
variable "sg_LB" {}

variable "port_lb" {
  type = "list"
}
