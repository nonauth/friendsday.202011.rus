include {
  path = find_in_parent_folders()
}


terraform {
  source = "${local.tfmodules_origin}//ssh-keys"
}


locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl")).inputs

  config           = local.common.config
  common_prefix    = local.config.common_prefix
  tfmodules_origin = local.common.tfmodules_origin
  current_dir      = get_terragrunt_dir()
  practice         = basename(dirname(local.current_dir))
}


dependency "users" {
  config_path = "../users/"
}


inputs = {
  keys = keys(dependency.users.outputs.this)
}
