
resource "aws_security_group" "allow_https_inbound" {
  name        = "allow_https"
  description = "Allow HTTPS outbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_https"
  }
}

resource "aws_security_group" "allow_ssh_inbound" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "allow_all_outbound" {
  name        = "allow_all_outbound"
  description = "Allow SSH all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all_outbound"
  }
}

# Create SSM VPC Endpoint
resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.eu-west-2.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.vpc.private_subnets[0]]
  security_group_ids  = [aws_security_group.allow_https_inbound.id, aws_security_group.allow_all_outbound.id]
  private_dns_enabled = true

  tags = {
    Name = "SSM Endpoint"
  }
}

# Create EC2 Messages VPC Endpoint
resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.eu-west-2.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.vpc.private_subnets[0]]
  security_group_ids  = [aws_security_group.allow_https_inbound.id, aws_security_group.allow_all_outbound.id]
  private_dns_enabled = true

  tags = {
    Name = "EC2 Messages Endpoint"
  }
}

# Create SSM Messages VPC Endpoint
resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.eu-west-2.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.vpc.private_subnets[0]]
  security_group_ids  = [aws_security_group.allow_https_inbound.id, aws_security_group.allow_all_outbound.id]
  private_dns_enabled = true

  tags = {
    Name = "SSM Messages Endpoint"
  }
}

module "vpc" {
  source                = "../modules/vpc"
  vpc_name              = "dan-vpc"
  private_subnets_count = 1
}