variable "domain_name" {
  type        = string
  description = "The domain name to use for the static site"
}

variable "project_name"{
  default = "Project"
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

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The instance type for the EC2"
}

variable "ami" {
  type = string
  default = "ami-034ef92d9dd822b08"
  description = "AMI id"
}