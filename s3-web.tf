resource "aws_s3_bucket" "web_bucket" {
  bucket = var.domain_name

}

resource "aws_s3_bucket_website_configuration" "default" {
  bucket = aws_s3_bucket.web_bucket.bucket
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "default" {
  bucket = aws_s3_bucket.web_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = ["arn:aws:s3:::${var.domain_name}/*"]
      },
    ]
  })
}

resource "aws_s3_object" "index_upload" {
  bucket       = aws_s3_bucket.web_bucket.id
  key          = "index.html"
  source       = "./index.html"
  acl          = "public-read"
  content_type = "text/html" #serves the index appropriately in the browser

}


