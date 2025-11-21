provider "aws" {
  region = var.region
}

########################################
# NETWORK LAYER
########################################

module "vpc" {
  source              = "./modules/vpc"
  region              = var.region
  vpc_id              = var.vpc_id
  availability_zone_a = var.availability_zone_a
  availability_zone_b = var.availability_zone_b
}


########################################
# COMPUTE LAYER
########################################

module "eks" {
  source = "./modules/eks"
  subnet_ids = [
    module.vpc.subnet_ids.public_a,
    module.vpc.subnet_ids.public_b,
  ]
}
