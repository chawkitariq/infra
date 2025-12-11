########################################
# NETWORK LAYER
########################################

module "vpc" {
  source = "./modules/vpc"
  vpc_id = var.vpc_id
}

########################################
# COMPUTE LAYER
########################################

module "eks" {
  source     = "./modules/eks"
  subnet_ids = module.vpc.private_subnet_ids
}
