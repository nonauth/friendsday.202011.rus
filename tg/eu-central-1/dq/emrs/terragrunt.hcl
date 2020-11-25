include {
  path = find_in_parent_folders()
}


terraform {
  source = "${local.tfmodules_origin}//aws-emr-clusters"
}


locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl")).inputs

  config           = local.common.config
  common_prefix    = local.config.common_prefix
  tfmodules_origin = local.common.tfmodules_origin
  current_dir      = get_terragrunt_dir()
  practice         = basename(dirname(local.current_dir))
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

dependency "key_pairs" {
  config_path = "../key-pairs"
}


inputs = {
  emr_names = [
    for key in values(dependency.key_pairs.outputs.this) : key.id
  ]

  log_uri = "s3://${dependency.s3.outputs.this.logs.bucket}/logs/"

  emr_managed_master_security_group = dependency.security_group.outputs.this.id
  emr_managed_slave_security_group  = dependency.security_group.outputs.this.id

  instance_profile = dependency.emr_ec2_profile.outputs.this.arn
  service_role     = dependency.emr_service_role.outputs.this.arn
  subnet_id        = dependency.vpc.outputs.public_subnets.0

  core_instance_count = 1

  applications = [
    "Spark",
    "Hive",
    "Hadoop",
    "JupyterHUB",
    "Zeppelin",
  ]

  bootstrap_actions = {
    deequ = {
      path = "s3://${dependency.s3.outputs.this.infr.bucket}/deequ.sh"
      args = [
        "${dependency.s3.outputs.this.infr.bucket}",
        "deequ-1.0.5.jar",
      ]
    }
    zeppelin = {
      path = "s3://${dependency.s3.outputs.this.infr.bucket}/zeppelin.sh"
      args = [
        "2FR67FUHX",
        "s3://${dependency.s3.outputs.this.landing.bucket}/zeppelin_notebooks/AWS_Deequ_demo_final.json",
      ]
    }
  }
}
