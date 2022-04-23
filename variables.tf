variable "domain_name" {
  type        = string
  description = "The domain name to use for the static site"
}

variable "bucket_name" {
  type        = string
  description = "Bucket name for hosting the website"
}

variable "project_name" {
  default     = "Fuzzy-Guacamole"
  type        = string
  description = "Name used on several resources"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-2"
}

variable "az_count" {
  default     = "1"
  description = "Number of availability zones we want"
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = true
  description = "Enables DNS hostnames in the VPC"
}

variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "Enables DNS support in the VPC"
}

variable "cidr" {
  type        = string
  default     = "172.16.0.0/24"
  description = "CIDR block for the VPC"
}

variable "quantity" {
  type        = number
  default     = 2
  description = "Number of subnets per type we want"
}

variable "key_name" {
  type        = string
  default     = "myKey"
  description = "EC2 key pair name"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The instance type for the EC2"
}

variable "ami" {
  type        = string
  default     = "ami-034ef92d9dd822b08"
  description = "AMI id"
}

variable "db_username" {
  type        = string
  default     = "admindbuser"
  description = "DB username"
}

variable "db_name" {
  type        = string
  default     = "master"
  description = "DB name"
}
