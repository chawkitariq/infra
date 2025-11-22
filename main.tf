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
    module.vpc.subnet_ids.private_a1,
    module.vpc.subnet_ids.private_b1,
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name

  depends_on = [
    module.eks
  ]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name

  depends_on = [
    module.eks
  ]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

module "lbc" {
  source = "./modules/aws-lbc"
  cluster_name = module.eks.cluster_name
  region = var.region
  vpc_id = var.vpc_id

  depends_on = [
    module.eks
  ]
}