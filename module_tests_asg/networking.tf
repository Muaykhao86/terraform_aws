module "vpc" {
  source = "../modules/vpc"
  vpc_name = var.project_name
  # cidr = var.vpc_cidr_block
  # azs             = data.aws_availability_zones.available.names
  # public_subnets  = 3
  # private_subnets = 3
  # newbits         = 8
  enable_nat_gateway = true
  single_nat_gateway = true
  # one_nat_gateway_per_az = false
  # manage_default_security_group = false
}