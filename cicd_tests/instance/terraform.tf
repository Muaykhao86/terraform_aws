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
  default_tags {
    tags = {
      Environment = "dev"
      Project     = "cicd"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "terraform-backend-terraformbackends3bucket-83j38nrsjqb8"
    key            = "instance"
    region         = "eu-west-2"
    dynamodb_table = "terraform-backend-TerraformBackendDynamoDBTable-112GK7RY2STXM"
  }
}
