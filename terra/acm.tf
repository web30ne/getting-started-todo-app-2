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
  validation_record_fqdns = [for dvo in aws_acm_certificate.assessment.domain_validation_options : dvo.resource_record_name]

  depends_on = [cloudflare_dns_record.acm_validation]
}
