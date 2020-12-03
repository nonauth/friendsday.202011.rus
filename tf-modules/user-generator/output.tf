output "this" {
  value = {
    for i in range(var.user_count) :
    random_pet.this[i].id => random_string.this[i].result
  }
}

output "users" {
  value = random_pet.this.*.id
}
