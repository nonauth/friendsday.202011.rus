include {
  path = find_in_parent_folders()
}


terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git//?ref=v2.64.0"
}


locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl")).inputs

  config           = local.common.config
  common_prefix    = local.config.common_prefix
  tfmodules_origin = local.common.tfmodules_origin
  current_dir      = get_terragrunt_dir()
  practice         = basename(dirname(local.current_dir))
  vpc              = local.config[local.practice].vpc
}


inputs = {
  name            = "${local.common_prefix}-${local.practice}"
  cidr            = local.vpc.cidr
  azs             = local.vpc.azs
  private_subnets = local.vpc.private_subnets
  public_subnets  = local.vpc.public_subnets
}
