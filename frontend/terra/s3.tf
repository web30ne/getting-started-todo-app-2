resource "aws_s3_bucket" "cloudproject" {
        bucket = local.base_domain_name
}

resource "aws_s3_bucket_policy" "cloudproject" {
        bucket = aws_s3_bucket.cloudproject.bucket
        policy = templatefile("${path.module}/files/s3/bucket_policy.json.tpl", {
                bucket_arn = aws_s3_bucket.cloudproject.arn
                distribution_arn = aws_cloudfront_distribution.cloudproject.arn
        })
}
