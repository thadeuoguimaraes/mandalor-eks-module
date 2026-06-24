locals {
  cluster_sg_id = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}

resource "aws_vpc_security_group_ingress_rule" "nodeport" {
  security_group_id = local.cluster_sg_id
  description       = "Allow NodePort services"
  from_port         = 30000
  to_port           = 32768
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = merge(var.tags, { Name = "${var.cluster_name}-nodeport" })
}

resource "aws_vpc_security_group_ingress_rule" "coredns_tcp" {
  security_group_id = local.cluster_sg_id
  description       = "Allow CoreDNS TCP"
  from_port         = 53
  to_port           = 53
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = merge(var.tags, { Name = "${var.cluster_name}-coredns-tcp" })
}

resource "aws_vpc_security_group_ingress_rule" "coredns_udp" {
  security_group_id = local.cluster_sg_id
  description       = "Allow CoreDNS UDP"
  from_port         = 53
  to_port           = 53
  ip_protocol       = "udp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = merge(var.tags, { Name = "${var.cluster_name}-coredns-udp" })
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = local.cluster_sg_id
  description       = "Allow HTTP"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = merge(var.tags, { Name = "${var.cluster_name}-http" })
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = local.cluster_sg_id
  description       = "Allow HTTPS"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = merge(var.tags, { Name = "${var.cluster_name}-https" })
}

resource "aws_vpc_security_group_ingress_rule" "http_alt" {
  security_group_id = local.cluster_sg_id
  description       = "Allow HTTP alternate"
  from_port         = 8080
  to_port           = 8080
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = merge(var.tags, { Name = "${var.cluster_name}-http-alt" })
}

resource "aws_vpc_security_group_ingress_rule" "https_alt" {
  security_group_id = local.cluster_sg_id
  description       = "Allow HTTPS alternate"
  from_port         = 8443
  to_port           = 8443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"

  tags = merge(var.tags, { Name = "${var.cluster_name}-https-alt" })
}
