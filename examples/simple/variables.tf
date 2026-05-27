variable "region" {
  type    = string
  default = "us-east-1"
}

variable "profile" {
  type    = string
  default = "default"
}

variable "cluster_name" {
  type    = string
  default = "mandalor-module-test"
}

variable "vpc_id" {
  type        = string
  description = "ID da VPC onde o cluster será criado."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "IDs das subnets privadas para os worker nodes."
}

variable "eks_addons" {
  type = map(object({
    version                     = string
    resolve_conflicts_on_create = optional(string, "OVERWRITE")
    resolve_conflicts_on_update = optional(string, "OVERWRITE")
    configuration_values        = optional(string, null)
  }))
  default = null
}
