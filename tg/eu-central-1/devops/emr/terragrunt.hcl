include {
  path = find_in_parent_folders()
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket         = local.tfstate_bucket
    key            = "${local.tfstate_prefix}/${local.environment}/${local.practice}/emr/${local.username}/terraform.tfstate"
    region         = local.aws_default_region
    dynamodb_table = "tf-state-lock-${local.environment}"
  }
}


terraform {
  source = "${local.tfmodules_origin}//aws-emr-cluster"
}


locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl")).inputs

  config             = local.common.config
  common_prefix      = local.config.common_prefix
  tfmodules_origin   = local.common.tfmodules_origin
  tfstate_bucket     = local.config.tfstate_bucket
  tfstate_prefix     = local.config.tfstate_prefix
  environment        = local.config.environment
  aws_default_region = local.config.aws_default_region
  current_dir        = get_terragrunt_dir()
  practice           = basename(dirname(local.current_dir))

  system_username = get_env("USER")
  fd_username     = get_env("FD_USER", "")
  username        = length(local.fd_username) > 0 ? local.fd_username : local.system_username
}

dependency "security_group" {
  config_path = "../security-group"
}

dependency "emr_ec2_profile" {
  config_path = "../emr-ec2-profile"
}

dependency "emr_service_role" {
  config_path = "../emr-service-role"
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "s3" {
  config_path = "../s3"
}

inputs = {
  name     = "${local.common_prefix}-${local.practice}-${local.username}"
  key_name = "fd-${local.username}"
  log_uri  = "s3://${dependency.s3.outputs.this.logs.bucket}/logs/"

  emr_managed_master_security_group = dependency.security_group.outputs.this.id
  emr_managed_slave_security_group  = dependency.security_group.outputs.this.id

  instance_profile = dependency.emr_ec2_profile.outputs.this.arn
  service_role     = dependency.emr_service_role.outputs.this.arn
  subnet_id        = dependency.vpc.outputs.public_subnets.0
}
