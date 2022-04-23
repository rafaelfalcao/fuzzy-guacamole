## Fuzzy-Guacamole

This terraform code deploys the necessary infrastructure for the challenge.

## Prepare the environment

- Make sure you have configured the provider [AWS Configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
- Run 'terraform init' to configure the backend

## Known Issues

Route53 Record creation sometimes throws this error: "The argument "alias.0.name" is required, but no definition was found."
If this happens, please just run 'terraform apply' once again.

## Thoughts

On the first task, I promptly considered using S3 as a solution for its high availability and simplicity regarding static web pages.
Another solution was maybe using another EC2 with a web server with ASG or maybe an ECS cluster.

On the third task, the Docker image is stored on DockerHub on my personal repository.
This could be extended to be stored on a private ECR and use CodeBuild,
CodeDeploy and CodePipeline in case there were to be made changes to the Dockerfile.

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
| random | 3.1.2 |
| tls | 3.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_alb.app-load-balancer](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/alb) | resource |
| [aws_alb_listener.alb-http-listener](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/alb_listener) | resource |
| [aws_alb_listener_rule.alb-listener-rule](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/alb_listener_rule) | resource |
| [aws_alb_target_group.alb-tg](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/alb_target_group) | resource |
| [aws_db_instance.myDB](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.default](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/db_subnet_group) | resource |
| [aws_ecs_cluster.default](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.my_ecs_service](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.my_task_definition](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/ecs_task_definition) | resource |
| [aws_instance.task2_instance](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/instance) | resource |
| [aws_key_pair.generated_key](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/key_pair) | resource |
| [aws_route53_record.domain](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/route53_record) | resource |
| [aws_route53_zone.zone](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/route53_zone) | resource |
| [aws_route_table.default](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/route_table) | resource |
| [aws_route_table_association.default](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/route_table_association) | resource |
| [aws_s3_bucket.web_bucket](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.default](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_website_configuration.default](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_s3_object.index_upload](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/s3_object) | resource |
| [aws_secretsmanager_secret.password](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.password](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.alb-sg](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/security_group) | resource |
| [aws_security_group.ec2-ssh](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/security_group) | resource |
| [aws_security_group.ecs_sg](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/security_group) | resource |
| [aws_security_group.rds-sg](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/security_group) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/subnet) | resource |
| [aws_subnet.private_1](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/subnet) | resource |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/resources/vpc) | resource |
| [random_id.default](https://registry.terraform.io/providers/hashicorp/random/3.1.2/docs/resources/id) | resource |
| [random_password.default](https://registry.terraform.io/providers/hashicorp/random/3.1.2/docs/resources/password) | resource |
| [tls_private_key.pk](https://registry.terraform.io/providers/hashicorp/tls/3.3.0/docs/resources/private_key) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/data-sources/availability_zones) | data source |
| [aws_secretsmanager_secret.password](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.password](https://registry.terraform.io/providers/hashicorp/aws/4.10.0/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ami | AMI id | `string` | `"ami-034ef92d9dd822b08"` | no |
| aws\_region | AWS region | `string` | `"eu-west-2"` | no |
| az\_count | Number of availability zones we want | `string` | `"1"` | no |
| bucket\_name | Bucket name for hosting the website | `string` | n/a | yes |
| cidr | CIDR block for the VPC | `string` | `"172.16.0.0/24"` | no |
| db\_name | DB name | `string` | `"master"` | no |
| db\_username | DB username | `string` | `"admindbuser"` | no |
| domain\_name | The domain name to use for the static site | `string` | n/a | yes |
| enable\_dns\_hostnames | Enables DNS hostnames in the VPC | `bool` | `true` | no |
| enable\_dns\_support | Enables DNS support in the VPC | `bool` | `true` | no |
| instance\_type | The instance type for the EC2 | `string` | `"t2.micro"` | no |
| key\_name | EC2 key pair name | `string` | `"myKey"` | no |
| project\_name | Name used on several resources | `string` | `"Fuzzy-Guacamole"` | no |
| quantity | Number of subnets per type we want | `number` | `2` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_ip | The public ip for ssh access |