module "aws_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = var.vpc_name
  cidr = var.vpc_cidr_block

  azs             = var.azs
  public_subnets  = [for i in range(var.public_subnets_count) : cidrsubnet(var.vpc_cidr_block, var.newbits, i)]
  private_subnets = [for i in range(var.private_subnets_count) : cidrsubnet(var.vpc_cidr_block, var.newbits, i + var.public_subnets_count)]

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

  manage_default_security_group = var.manage_default_security_group
}