resource "aws_cloudfront_origin_access_control" "cloudproject" {
  name                              = "${local.title}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cloudproject" {        # <- this name makes .cloudproject.arn work
  enabled             = true
  default_root_object = "index.html"
  aliases             = [local.domain_name]

  origin {
    domain_name              = aws_s3_bucket.cloudproject.bucket_regional_domain_name
    origin_id                = "s3-${local.title}"
    origin_access_control_id = aws_cloudfront_origin_access_control.cloudproject.id
  }

  default_cache_behavior {
    target_origin_id       = "s3-${local.title}"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"   # AWS managed "CachingOptimized"
  }

  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"
  }
  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.assessment.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
