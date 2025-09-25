terraform{

    required_version = ">= 1.0.0"
    
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
    
    backend "s3" {
        bucket         = "demo-tf-eks-suraj1818-bucket"
        key            = "terraform/state/eks-cluster/terraform.tfstate"
        region         = "ap-south-1"
        dynamodb_table = "terraform-state-suraj1818-eks-lock"
        encrypt        = true
        }
    }



module "vpc" {
  source = "./modules/vpc"

  vpc_cidr              = var.vpc_cidr
  availability_zones    = var.availability_zones
  cluster_name          = var.cluster_name
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
}


module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = module.vpc.private_subnet_ids
  vpc_id          = module.vpc.vpc_id

  node_groups = var.node_groups
}   