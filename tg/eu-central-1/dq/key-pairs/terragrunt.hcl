include {
  path = find_in_parent_folders()
}


terraform {
  source = "${local.tfmodules_origin}//aws-key-pairs"
}


locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl")).inputs

  config           = local.common.config
  common_prefix    = local.config.common_prefix
  tfmodules_origin = local.common.tfmodules_origin
  current_dir      = get_terragrunt_dir()
  practice         = basename(dirname(local.current_dir))
}


dependency "ssh_keys" {
  config_path = "../ssh-keys/"
}


inputs = {
  prefix      = "${local.common_prefix}-${local.practice}"
  public_keys = dependency.ssh_keys.outputs.this
}
