resource "aws_instance" "private_instance_test" {
  count         = var.instance_count
  ami           = data.aws_ami.this.id
  instance_type = var.instance_type
  subnet_id     = module.vpc.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.allow_all_outbound.id]
  iam_instance_profile = aws_iam_instance_profile.session_manager.name
  tags = {
    Name = "${var.ec2_name}-private-instance-${count.index + 1}"
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
