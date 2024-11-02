variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway"
  type        = bool
}

variable "single_nat_gateway" {
  description = "Use a single NAT gateway"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "cluster_endpoint_public_access" {
  description = "Enable public access to the EKS cluster endpoint"
  type        = bool
}

variable "enable_cluster_creator_admin_permissions" {
  description = "Enable admin permissions for the cluster creator"
  type        = bool
}

variable "node_ami_type" {
  description = "AMI type for EKS managed node groups"
  type        = string
}

variable "eks_managed_node_groups" {
  description = "Configuration for EKS managed node groups"
  type        = map(any)
}
