resource "aws_route53_zone" "zone" {
  name = var.domain_name
}

resource "aws_route53_record" "domain" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = aws_s3_bucket.web_bucket.website_endpoint
    zone_id                = aws_s3_bucket.web_bucket.hosted_zone_id
    evaluate_target_health = false
  }
  depends_on = [
    aws_s3_bucket.web_bucket,
    aws_route53_zone.zone
  ]
}
