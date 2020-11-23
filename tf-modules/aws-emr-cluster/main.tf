resource "aws_emr_cluster" "this" {
  name          = var.name
  release_label = var.release_label
  applications  = var.applications
  log_uri       = var.log_uri

  termination_protection            = var.termination_protection
  keep_job_flow_alive_when_no_steps = var.keep_job_flow_alive_when_no_steps

  ec2_attributes {
    key_name                          = var.key_name
    subnet_id                         = var.subnet_id
    emr_managed_master_security_group = var.emr_managed_master_security_group
    emr_managed_slave_security_group  = var.emr_managed_slave_security_group
    instance_profile                  = var.instance_profile
  }

  master_instance_group {
    instance_type  = var.master_instance_type
    instance_count = var.master_instance_count
  }

  core_instance_group {
    instance_type  = var.core_instance_type
    instance_count = var.core_instance_count

    ebs_config {
      size                 = var.core_ebs_size
      type                 = var.core_ebs_type
      volumes_per_instance = var.core_volumes_per_instance
    }
  }

  ebs_root_volume_size = var.ebs_root_valume_size

  dynamic "bootstrap_action" {
    for_each = var.bootstrap_actions
    iterator = item

    content {
      path = item.value.path
      name = item.key
      args = item.value.args
    }
  }

  service_role = var.service_role

  tags = var.tags
}
