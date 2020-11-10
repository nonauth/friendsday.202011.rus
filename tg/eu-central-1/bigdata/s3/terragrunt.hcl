include {
  path = find_in_parent_folders()
}


terraform {
  source = "${local.tfmodules_origin}//aws-s3-buckets"
}


locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl")).inputs

  config           = local.common.config
  common_prefix    = local.config.common_prefix
  tfmodules_origin = local.common.tfmodules_origin
  current_dir      = get_terragrunt_dir()
  practice         = basename(dirname(local.current_dir))
}


inputs = {
  s3_buckets = {
    landing = {
      prefix = "${local.common_prefix}-${local.practice}"
      acl    = "private"

      tags = {
        Description = "Landing layer"
      }
    }

    raw = {
      prefix = "${local.common_prefix}-${local.practice}"
      acl    = "private"

      tags = {
        Description = "RAW layer"
      }
    }

    logs = {
      prefix = "${local.common_prefix}-${local.practice}"
      acl    = "private"

      tags = {
        Description = "EMR logs"
      }
    }

    infr = {
      prefix = "${local.common_prefix}-${local.practice}"
      acl    = "private"

      tags = {
        Description = "EMR bootstrap scirpts"
      }
    }
  }
}
