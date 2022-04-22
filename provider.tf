terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.10.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
