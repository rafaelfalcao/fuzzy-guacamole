variable "domain_name" {
  type        = string
  description = "The domain name to use for the static site"
}

variable "bucket_name" {
    type = string
    description = "The name of the bucket"
}
variable "aws_region" {
  type        = string
  description = "The AWS region"
  default     = "eu-west-2"
}

variable "tags" {
  description = "Tags used by multiple resources"
}

variable "az_count" {
  default     = "1"
  description = "number of availability zones we want"
}