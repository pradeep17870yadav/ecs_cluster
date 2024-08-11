provider "aws" {
  region = var.Region
}

data "aws_ecs_cluster" "existing_cluster" {
  cluster_name = var.cluster_name
}

data "aws_vpc" "default" {
  default = true
}

# Get default subnets
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}