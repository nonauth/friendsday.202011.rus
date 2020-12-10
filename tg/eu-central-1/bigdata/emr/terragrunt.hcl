include {
  path = find_in_parent_folders()
}


terraform {
  source = "${local.tfmodules_origin}//aws-emr-cluster"
}


locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl")).inputs

  config           = local.common.config
  common_prefix    = local.config.common_prefix
  tfmodules_origin = local.common.tfmodules_origin
  current_dir      = get_terragrunt_dir()
  practice         = basename(dirname(local.current_dir))
}

dependencies {
  paths = [
    "../security-group",
    "../emr-ec2-profile",
    "../emr-service-role",
    "../vpc",
    "../s3",
  ]
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
  name     = "${local.common_prefix}-${local.practice}"
  key_name = local.config.key_name
  log_uri  = "s3://${dependency.s3.outputs.this.logs.bucket}/logs/"

  emr_managed_master_security_group = dependency.security_group.outputs.this.id
  emr_managed_slave_security_group  = dependency.security_group.outputs.this.id

  core_instance_count  = 3
  core_instance_type   = "m5.xlarge"
  master_instance_type = "m5.xlarge"

  instance_profile = dependency.emr_ec2_profile.outputs.this.arn
  service_role     = dependency.emr_service_role.outputs.this.arn
  subnet_id        = dependency.vpc.outputs.public_subnets.0
}
