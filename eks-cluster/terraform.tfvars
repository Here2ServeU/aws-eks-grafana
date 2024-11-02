region = "us-east-1"

vpc_name             = "t2s-services-vpc"
vpc_cidr             = "10.0.0.0/16"
private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
enable_nat_gateway   = true
single_nat_gateway   = true
enable_dns_hostnames = true

cluster_version                      = "1.29"
cluster_endpoint_public_access       = true
enable_cluster_creator_admin_permissions = true

node_ami_type = "AL2_x86_64"

eks_managed_node_groups = {
  one = {
    name = "node-group-1"
    instance_types = ["t3.small"]
    min_size = 1
    max_size = 4
    desired_size = 4
  }
  two = {
    name = "node-group-2"
    instance_types = ["t3.small"]
    min_size = 1
    max_size = 3
    desired_size = 1
  }
}
