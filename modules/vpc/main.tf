locals {
  project_name  = try(var.project_name, "new-project")
  vpc_cidr_block = try(var.vpc_cidr_block, "10.0.0.0/16")
  newbits = try(var.newbits, 8)
  public_subnets_count = try(var.public_subnets_count, 2)
  private_subnets_count = try(var.private_subnets_count, 2)
  aws_availability_zones = try(var.azs, ["eu-west-2a", "eu-west-2b", "eu-west-2c"])
  enable_nat_gateway = try(var.enable_nat_gateway, false);
  single_nat_gateway = try(var.single_nat_gateway, false);
  one_nat_gateway_per_az = try(var.one_nat_gateway_per_az, false);
  manage_default_security_group = try(var.manage_default_security_group, false);
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = local.project_name
  cidr = local.vpc_cidr_block

  azs             = local.aws_availability_zones
  public_subnets  = [for i in range(local.public_subnets_count) : cidrsubnet(local.vpc_cidr_block, local.newbits, i)]
  private_subnets = [for i in range(local.private_subnets_count) : cidrsubnet(local.vpc_cidr_block, local.newbits, i + local.public_subnets_count)]

  enable_nat_gateway = local.enable_nat_gateway
  single_nat_gateway = local.single_nat_gateway
  one_nat_gateway_per_az = local.one_nat_gateway_per_az

  manage_default_security_group = local.manage_default_security_group
}

output "vpc_id" {
  value = module.vpc.vpc_id
  description = "The ID of the VPC"
}
