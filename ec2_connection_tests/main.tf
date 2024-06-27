resource "aws_instance" "connect_test" {
  ami           = data.aws_ami.this.id
  instance_type = var.instance_type
  subnet_id     = module.vpc.private_subnets[0]
  # user_data              = filebase64("${path.root}/../scripts/user_data.sh")
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  # key_name               = aws_key_pair.this.key_name
  iam_instance_profile = aws_iam_instance_profile.session_manager.name
  tags = {
    Name = "${var.ec2_name}-ssh"
  }
}

resource "aws_instance" "private_connect_test" {
  ami           = data.aws_ami.this.id
  instance_type = var.instance_type
  subnet_id     = module.vpc.private_subnets[0]
  # user_data              = filebase64("${path.root}/../scripts/user_data.sh")
  vpc_security_group_ids = [aws_security_group.allow_https.id]
  # key_name               = aws_key_pair.this.key_name
  iam_instance_profile = aws_iam_instance_profile.session_manager.name
  tags = {
    Name = "${var.ec2_name}-https"
  }
}

data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

module "vpc" {
  source                = "../modules/vpc"
  vpc_name              = "dan-vpc"
  private_subnets_count = 1
}

resource "aws_security_group" "allow_https" {
  name        = "allow_https"
  description = "Allow HTTPS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_https"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_http_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

# Create SSM VPC Endpoint
resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.eu-west-2.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [module.vpc.private_subnets[0]]
  security_group_ids  = [aws_security_group.allow_https.id]
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
  security_group_ids  = [aws_security_group.allow_https.id]
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
  security_group_ids  = [aws_security_group.allow_https.id]
  private_dns_enabled = true

  tags = {
    Name = "SSM Messages Endpoint"
  }
}

resource "aws_ec2_instance_connect_endpoint" "ec2connect" {
  subnet_id          = module.vpc.private_subnets[0]
  security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Name = "EC2 Instance Connect Endpoint"
  }
}
