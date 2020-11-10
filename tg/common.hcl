locals {
  current_dir      = get_terragrunt_dir()
  config           = yamldecode(file("${local.current_dir}/config.yml"))
  tfmodules_origin = "${local.current_dir}/../tf-modules"

}

inputs = {
  config           = local.config
  tfmodules_origin = local.tfmodules_origin
}
