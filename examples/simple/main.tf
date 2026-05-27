provider "aws" {
  region  = var.region
  profile = var.profile
}

module "eks" {
  source = "github.com/thadeuguimaraes/mandalor-eks-module?ref=v1.0.0"

  cluster_name       = var.cluster_name
  kubernetes_version = "1.32"

  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids

  enable_node_group_main         = true
  node_group_main_instance_types = ["t3.xlarge"]
  node_group_main_scaling = {
    min     = 1
    max     = 3
    desired = 1
  }

  enable_cluster_autoscaler = true
  enable_metrics_server     = true
  enable_kube_state_metrics = false

  enable_node_group_spot     = false
  enable_node_group_critical = false
  enable_node_group_graviton = false

  eks_addons = var.eks_addons != null ? var.eks_addons : {
    vpc-cni            = { version = "v1.21.1-eksbuild.8" }
    coredns            = { version = "v1.11.4-eksbuild.33" }
    kube-proxy         = { version = "v1.32.13-eksbuild.8" }
    aws-ebs-csi-driver = { version = "v1.59.0-eksbuild.1" }
  }

  tags = {
    Environment = "test"
    ManagedBy   = "terraform"
  }
}
