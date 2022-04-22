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
of maxx_connections to the database of '0', thus preventing CMS to access the database or any other access.
Update 08/04/2022 - This has been tried again with no success. The result is the same. Currently waiting for community help.

# Architecture

Please refer to [Confluence - Infrastructure](https://mindera.atlassian.net/wiki/spaces/MW/pages/3447554049/Infrastructure) for
an Architecture diagram and a brief explanation of how we implemented this solution.