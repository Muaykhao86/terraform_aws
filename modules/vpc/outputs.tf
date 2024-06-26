output "vpc_id" {
  value = module.aws_vpc.vpc_id
  description = "The ID of the VPC"
}

output "public_subnets" {
  value = module.aws_vpc.public_subnets
  description = "The IDs of the public subnets"
}

output "private_subnets" {
  value = module.aws_vpc.private_subnets
  description = "The IDs of the private subnets"
}

output "availability_zones" {
  value = module.aws_vpc.azs
  description = "The availability zones in which the VPC is created"
}

output "vpc_cidr_block" {
  value = module.aws_vpc.vpc_cidr_block
  description = "The CIDR block of the VPC"
}

output "private_route_table_ids" {
  value = module.aws_vpc.private_route_table_ids
  description = "The IDs of the private route tables"
}
