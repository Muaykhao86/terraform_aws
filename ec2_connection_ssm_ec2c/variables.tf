variable "ec2_name" {
  type        = string
  default     = "connect_test"
  description = "The name of the EC2 instance"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "The type of EC2 instance"
}

variable "username" {
  type        = string
  description = "The username for the OS"
  default     = "ec2-user"
}

variable "instance_count" {
  type        = number
  default     = 1
  description = "The number of EC2 instances to create"
}
