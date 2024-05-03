output "public_ip" {
  value = aws_instance.connect_test.public_ip
}

output "ssh_key_location" {
  value = data.external.ssh_key.result.path
}
