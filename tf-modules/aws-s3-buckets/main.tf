resource "random_string" "this" {
  for_each = var.s3_buckets

  length  = 8
  lower   = true
  number  = true
  special = false
  upper   = false
}

resource "aws_s3_bucket" "this" {
  for_each = var.s3_buckets

  bucket = join("-", [
    each.value.prefix,
    each.key,
    random_string.this[each.key].result
  ])

  acl = each.value.acl

  tags = merge(var.tags, each.value.tags)

  depends_on = [
    random_string.this,
  ]
}
