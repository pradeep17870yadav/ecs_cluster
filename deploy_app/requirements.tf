provider "aws" {
  region = var.Region
}

data "terraform_remote_state" "other" {
  backend = "s3"  # or "local", "azurerm", etc.
  config = {
    bucket =  "terraform-tf-state-file-bucket-12"
    key    = "terraform.tfstate"
    region = var.Region
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