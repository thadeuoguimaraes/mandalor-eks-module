provider "aws" {
  region  = var.region
  profile = var.profile
}

module "eks" {
  source = "../../"

  cluster_name       = var.cluster_name
  kubernetes_version = "1.35"

  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids
  public_subnet_ids  = var.public_subnet_ids

  # KMS encryption for secrets
  enable_kms_encryption = true

  # Authentication
  authentication_mode = "API_AND_CONFIG_MAP"
  enable_zonal_shift  = true

  # Control plane logs
  cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  # Node Groups
  enable_node_group_main         = true
  node_group_main_instance_types = ["t3.xlarge"]
  node_group_main_scaling = {
    min     = 2
    max     = 10
    desired = 2
  }

  enable_node_group_spot         = true
  node_group_spot_instance_types = ["t3.xlarge", "t3.2xlarge", "m5.xlarge"]
  node_group_spot_scaling = {
    min     = 0
    max     = 20
    desired = 2
  }

  enable_node_group_critical         = true
  node_group_critical_instance_types = ["t3.large"]
  node_group_critical_scaling = {
    min     = 2
    max     = 6
    desired = 2
  }

  enable_node_group_graviton         = true
  node_group_graviton_instance_types = ["t4g.large", "c7g.large"]
  node_group_graviton_scaling = {
    min     = 0
    max     = 10
    desired = 1
  }

  enable_node_group_graviton_spot = true
  node_group_graviton_spot_scaling = {
    min     = 0
    max     = 20
    desired = 0
  }

  # EKS Addons
  eks_addons = {
    vpc-cni = {
      version = "v1.22.2-eksbuild.1"
    }
    coredns = {
      version = "v1.13.2-eksbuild.11"
    }
    kube-proxy = {
      version = "v1.35.0-eksbuild.2"
    }
    aws-ebs-csi-driver = {
      version = "v1.62.0-eksbuild.1"
    }
  }

  # Helm charts
  enable_cluster_autoscaler        = true
  cluster_autoscaler_chart_version = "9.58.0"

  # Managed externally via helm_metrics_server.tf and helm_kube_state_metrics.tf
  enable_metrics_server     = false
  enable_kube_state_metrics = false

  enable_node_termination_handler        = true
  node_termination_handler_chart_version = "0.21.0"

  enable_ingress_nginx        = true
  ingress_nginx_chart_version = "4.15.1"

  enable_cert_manager        = true
  cert_manager_chart_version = "v1.20.2"

  tags = {
    Environment = "prod"
    ManagedBy   = "terraform"
    Project     = var.cluster_name
  }
}
