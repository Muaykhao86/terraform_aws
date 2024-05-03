resource "aws_instance" "connect_test" {
  ami                    = data.aws_ami.this.id
  instance_type          = var.instance_type
  user_data              = filebase64("${path.root}/../scripts/user_data.sh")
  vpc_security_group_ids = [aws_security_group.allow_http_and_ssh.id]
  key_name               = aws_key_pair.this.key_name
  iam_instance_profile   = aws_iam_instance_profile.session_manager.name
  tags = {
    Name = var.ec2_name
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

data "aws_vpc" "this" {
  cidr_block = "172.31.0.0/16"
}

resource "aws_security_group" "allow_http_and_ssh" {
  name        = "allow_http_and_ssh"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = data.aws_vpc.this.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
    Name = "allow_http"
  }
}

resource "aws_key_pair" "this" {
  key_name   = "dan-key"
  public_key = file(data.external.ssh_key.result.path)
}

# just testing the data source here
data "external" "ssh_key" {
  program = ["bash", "${path.root}/../scripts/get_path.sh"]

  query = {
    file_path = ".ssh/id_rsa.pub"
    home_dir  = "Users"
    user_name = var.username
  }
}
