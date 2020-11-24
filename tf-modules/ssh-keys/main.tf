resource "tls_private_key" "this" {
  for_each = toset(var.keys)

  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}

resource "local_file" "this" {
  for_each = toset(var.keys)

  content  = tls_private_key.this[each.value].private_key_pem
  filename = "${path.module}/private-keys/${each.value}"

  file_permission      = "0600"
  directory_permission = "0700"

  depends_on = [
    tls_private_key.this
  ]
}
