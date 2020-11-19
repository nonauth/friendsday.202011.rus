remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket         = local.tfstate_bucket
    key            = "${local.tfstate_prefix}/${local.environment}/${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_default_region
    dynamodb_table = "tf-state-lock-${local.environment}"
  }
}


generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite"

  contents = <<-EOF
    terraform {
      required_version = "= ${local.terraform_version}"
    }

    provider "aws" {
      version = "= ${local.aws_provider_version}"
      region = "${local.aws_region}"
    }
  EOF
}


locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl")).inputs

  config             = local.common.config
  tfstate_bucket     = local.config.tfstate_bucket
  tfstate_prefix     = local.config.tfstate_prefix
  aws_default_region = local.config.aws_default_region
  environment        = local.config.environment
  iam_path           = local.config.iam_path

  aws_region = split("/", path_relative_to_include())[0]

  terraform_version    = local.config.terraform_version
  aws_provider_version = local.config.aws_provider_version

  tags = {
    ManagedBy     = "Terraform"
    TFVersion     = local.terraform_version
    TFAWSProvider = local.aws_provider_version
    Environment   = local.environment
  }
}


inputs = {
  iam_path      = local.iam_path
  aws_region    = local.aws_default_region
  common_prefix = local.config.common_prefix
  tags          = local.tags
}
