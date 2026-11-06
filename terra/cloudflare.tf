data "cloudflare_zones" "main" {
  name = local.base_domain_name
}

resource "cloudflare_dns_record" "acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.assessment.domain_validation_options : dvo.domain_name => {
      name    = trimsuffix(dvo.resource_record_name, ".")
      content = trimsuffix(dvo.resource_record_value, ".")
      type    = dvo.resource_record_type
    }
  }

  zone_id = data.cloudflare_zones.main.result[0].id
  name    = each.value.name
  content = each.value.content
  type    = each.value.type
  ttl     = 60
  proxied = false
}

resource "cloudflare_dns_record" "site" {
  zone_id = data.cloudflare_zones.main.result[0].id
  name    = local.domain_name
  content = aws_cloudfront_distribution.cloudproject.domain_name
  type    = "CNAME"
  ttl     = 300
  proxied = false
}
