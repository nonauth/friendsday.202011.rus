output "this" {
  value = {
    for k, v in aws_emr_cluster.this :
    k => v.master_public_dns
  }
}
