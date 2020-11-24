include {
  path = find_in_parent_folders()
}


terraform {
  source = "${local.tfmodules_origin}//aws-security-group"
}


locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl")).inputs

  config           = local.common.config
  common_prefix    = local.config.common_prefix
  tfmodules_origin = local.common.tfmodules_origin
  current_dir      = get_terragrunt_dir()
  practice         = basename(dirname(local.current_dir))
}


dependency "vpc" {
  config_path = "../vpc"
}


inputs = {
  name        = "${local.common_prefix}-${local.practice}-emr"
  vpc_id      = dependency.vpc.outputs.vpc_id
  description = "Friedsday EMR cluster for ${local.practice}"

  ingress_rules = {
    ssh = {
      from_port   = 22
      to_port     = 22
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
