module "us_east_1_certificate" {
  source      = "../modules/certificate"
  domain_name = data.aws_route53_zone.hosted_zone.name
  id          = data.aws_route53_zone.hosted_zone.id
  providers = {
    aws = aws.virginia
  }
}