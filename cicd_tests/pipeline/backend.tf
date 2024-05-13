terraform {
  backend "s3" {
    bucket         = "terraform-backend-terraformbackends3bucket-83j38nrsjqb8"
    key            = "pipeline"
    region         = "eu-west-2"
    dynamodb_table = "terraform-backend-TerraformBackendDynamoDBTable-112GK7RY2STXM"
  }
}
