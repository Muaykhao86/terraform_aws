# resource "aws_key_pair" "this" {
#   key_name   = "dan-key"
#   # public_key = file(data.external.ssh_key.result.path)
#   # Below is the better way to do it just wanted to test with external command/script
#   public_key = file("~/.ssh/id_rsa.pub")
# }

# just testing the data source here
# data "external" "ssh_key" {
#   program = ["bash", "${path.root}/../scripts/get_path.sh"]

#   query = {
#     file_path = ".ssh/id_rsa.pub"
#     home_dir  = "Users"
#     user_name = var.username
#   }
# }