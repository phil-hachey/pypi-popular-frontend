variable "region" {
  default = "us-east-1"
}

variable "hosted_zone_id" {
  default = "Z2XW84BSA35BQJ"
}

terraform {
  backend "s3" {
    bucket = "pypi-popular-terraform"
    key    = "state"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "${var.region}"
}

resource "aws_s3_bucket" "site_bucket" {
  bucket = "pypi-popular.com"
  acl    = "public-read"

  # policy = "${file("policy.json")}"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_cloudfront_distribution" "site_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.site_bucket.bucket_domain_name}"
    origin_id   = "pypi_popular"
  }

  enabled = true
  is_ipv6_enabled = true
  default_root_object = "index.html"

  aliases = ["pypi-popular.com"]

  default_cache_behavior {
    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods = ["GET", "HEAD"]

    target_origin_id = "pypi_popular"

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"

    min_ttl = 0
    default_ttl = 0
    max_ttl = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations = ["US", "CA", "GB", "DE"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

resource "aws_route53_record" "www" {
  zone_id = "${var.hosted_zone_id}"
  name = "pypi-popular.com"
  type = "A"

  alias {
    name = "${aws_cloudfront_distribution.site_distribution.domain_name}"
    zone_id = "${aws_cloudfront_distribution.site_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}
