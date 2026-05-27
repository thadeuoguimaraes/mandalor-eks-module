region  = "us-east-1"
profile = "dev"

cluster_name = "mandalor-module-test"

vpc_id = "vpc-071d5b56cdf392de0"

private_subnet_ids = [
  "subnet-098b83c6d809b4ede",
  "subnet-05308311025e5454b",
  "subnet-038935f66ad932d2c",
]

eks_addons = {
  vpc-cni = {
    version = "v1.21.1-eksbuild.8"
  }
  coredns = {
    version = "v1.11.4-eksbuild.33"
  }
  kube-proxy = {
    version = "v1.32.13-eksbuild.8"
  }
  aws-ebs-csi-driver = {
    version = "v1.59.0-eksbuild.1"
  }
}
