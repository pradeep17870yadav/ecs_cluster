provider "aws" {
  region = var.Region
}

terraform {
  backend "s3" {
    bucket         = "terraform-tf-state-file-bucket-12"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
  }
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