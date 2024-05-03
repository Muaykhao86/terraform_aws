terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.47.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
  alias  = "london"
  default_tags {
    tags = {
      Environment = "dev"
      Project     = "terraform"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "virginia"
  default_tags {
    tags = {
      Environment = "dev"
      Project     = "terraform"
    }
  }
}