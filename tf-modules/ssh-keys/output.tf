output "this" {
  value = {
    for key in var.keys :
    key =>
    tls_private_key.this[key].public_key_openssh
  }
}
