resource "random_pet" "this" {
  count = var.user_count
}

resource "random_string" "this" {
  count = var.user_count

  length  = var.password_length
  lower   = var.use_lower
  number  = var.use_number
  special = var.use_special
  upper   = var.use_upper

  depends_on = [
    random_pet.this,
  ]
}
