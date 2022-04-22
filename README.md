# Mindera Website Infrastructure

This terraform code deploys the necessary infrastructure for Mindera Website:

- GCP bucket for static assets (frontend files)
- Load balancer to access the frontend and the CMS
- CloudRun service to deploy CMS image
- Artifact Registry
- PostgreSQL database for CMS
- StatusCake for uptime checking of FE and CMS
- CloudArmor for CMS restricted access

# Prepare the environment

- Install [pre-commit](https://pre-commit.com/) and [terraform-docs](https://github.com/terraform-docs/terraform-docs)
- Run 'pre-commit install'
- Make sure you have configured the provider [Google Provider Configuration](https://registry.terraform.io/providers/hashicorp/google/3.71.0/docs/guides/provider_reference)
    - 'gcloud auth list' lists all the accounts Terraform has configured
    - 'gcloud auth application-default' manages your active Application Default Credentials
- Run 'terraform init' to configure the backend

## Known Issues

We currently use 'g1-small' for our database since 'f1-small' was causing us to have a number
of maxx\_connections to the database of '0', thus preventing CMS to access the database or any other access.
Update 08/04/2022 - This has been tried again with no success. The result is the same. Currently waiting for community help.

# Architecture

Please refer to [Confluence - Infrastructure](https://mindera.atlassian.net/wiki/spaces/MW/pages/3447554049/Infrastructure) for
an Architecture diagram and a brief explanation of how we implemented this solution.

## Requirements

| Name | Version |
|------|---------|
| aws | 4.10.0 |
| local | 2.2.2 |
| random | 3.1.2 |
| tls | 3.3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 4.10.0 |
| tls | 3.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.task2_instance](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/instance) | resource |
| [aws_key_pair.generated_key](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/key_pair) | resource |
| [aws_route53_record.default](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/route53_record) | resource |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/route53_zone) | resource |
| [aws_route_table.default](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/route_table) | resource |
| [aws_route_table_association.default](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/route_table_association) | resource |
| [aws_s3_bucket.web_bucket](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.default](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_website_configuration.default](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_s3_object.index_upload](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/s3_object) | resource |
| [aws_security_group.allow-ssh](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/security_group) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/subnet) | resource |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/vpc) | resource |
| [tls_private_key.pk](https://registry.terraform.io/providers/hashicorp/tls/3.3.0/docs/resources/private_key) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | AMI id | `string` | `"ami-034ef92d9dd822b08"` | no |
| aws\_region | AWS region | `string` | `"eu-west-2"` | no |
| az\_count | Number of availability zones we want | `string` | `"1"` | no |
| bucket\_name | Bucket name for hosting the website | `string` | n/a | yes |
| cidr | CIDR block for the VPC | `string` | `"172.16.0.0/24"` | no |
| domain\_name | The domain name to use for the static site | `string` | n/a | yes |
| enable\_dns\_hostnames | Enables DNS hostnames in the VPC | `bool` | `true` | no |
| enable\_dns\_support | Enables DNS support in the VPC | `bool` | `true` | no |
| instance\_type | The instance type for the EC2 | `string` | `"t2.micro"` | no |
| key\_name | Ec2 key pair name | `string` | `"myKey"` | no |
| project\_name | Name used on several resources | `string` | `"Fuzzy-Guacamole"` | no |
| quantity | Number of subnets per type we want | `number` | `2` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_ip | The public ip for ssh access |