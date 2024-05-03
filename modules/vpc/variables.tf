variable "vpc_name" {
  description = "The name of the project"
  type        = string
  default     = "new-project"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "newbits" {
  description = "The new bits for the subnet"
  type        = number
  default     = 8
}

variable "public_subnets_count" {
  description = "The number of public subnets"
  type        = number
  default     = 2
}

variable "private_subnets_count" {
  description = "The number of private subnets"
  type        = number
  default     = 2
}

variable "azs" {
  description = "The availability zones"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

variable "enable_nat_gateway" {
  description = "Whether to enable NAT gateway"
  type        = bool
  default     = false
}

variable "single_nat_gateway" {
  description = "Whether to use a single NAT gateway"
  type        = bool
  default     = false
}

variable "one_nat_gateway_per_az" {
  description = "Whether to use one NAT gateway per availability zone"
  type        = bool
  default     = false
}

variable "manage_default_security_group" {
  description = "Whether to manage the default security group"
  type        = bool
  default     = false
}