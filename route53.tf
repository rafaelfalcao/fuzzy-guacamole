resource "aws_route53_zone" "default" {
  name = "merc-benz.io"
  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.default.zone_id
  name    = "www.merc-benz.io"
  type    = "A"
  alias {
    name                   = aws_elb.elb.dns_name
    zone_id                = aws_elb.elb.zone_id
    evaluate_target_health = true
  }
}

output "name_server" {
  value = aws_route53_zone.default.name_servers
}

