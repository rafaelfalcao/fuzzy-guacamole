# Fuzzy-Guacamole

This terraform code deploys the necessary infrastructure for this project:


# Prepare the environment

- Install [pre-commit](https://pre-commit.com/) and [terraform-docs](https://github.com/terraform-docs/terraform-docs)
- Run 'pre-commit install'
- Make sure you have configured the provider [Google Provider Configuration](https://registry.terraform.io/providers/hashicorp/google/3.71.0/docs/guides/provider_reference)
    - 'gcloud auth list' lists all the accounts Terraform has configured
    - 'gcloud auth application-default' manages your active Application Default Credentials
- Run 'terraform init' to configure the backend

## Known Issues


# Architecture

