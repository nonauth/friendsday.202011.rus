resource "aws_key_pair" "this" {
  for_each = var.public_keys

  key_name   = join("-", compact([var.prefix, each.key]))
  public_key = each.value

  tags = var.tags
}
