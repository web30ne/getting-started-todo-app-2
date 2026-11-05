resource "aws_acm_certificate" "assessment" {
  provider	    = aws.us-east-1
  domain_name       = local.domain_name
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "assessment" {
  provider                = aws.us-east-1
  certificate_arn         = aws_acm_certificate.assessment.arn
  validation_record_fqdns = [for r in aws_route53_record.assessment : r.fqdn]
}
