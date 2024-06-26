# output "public_ip" {
#   value = aws_instance.connect_test.public_ip
# }

# output "ssh_key_location" {
#   value = data.external.ssh_key.result.path
# }

# Output the VPC Endpoint IDs
output "ssm_endpoint_id" {
  value = aws_vpc_endpoint.ssm.id
}

output "ec2messages_endpoint_id" {
  value = aws_vpc_endpoint.ec2messages.id
}

output "ssmmessages_endpoint_id" {
  value = aws_vpc_endpoint.ssmmessages.id
}

# output "public_subnets" {
#   value = module.vpc.public_subnets
# }

# output "private_subnets" {
#   value = module.vpc.private_subnets
# }

# output "vpc_id" {
#   value = module.vpc.vpc_id
# }