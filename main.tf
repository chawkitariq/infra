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

module "lbc" {
  source                 = "./modules/aws-lbc"
  cluster_name           = module.eks.cluster_name
  region                 = var.region
  vpc_id                 = var.vpc_id
  enable_alb_gateway_api = true
  enable_nlb_gateway_api = true

  depends_on = [ module.eks ]
}
