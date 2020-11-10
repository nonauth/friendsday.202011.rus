resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags        = var.tags
}

resource "aws_security_group_rule" "egress" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.this.id
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "self" {
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  self              = true
}


resource "aws_security_group_rule" "ingress" {
  for_each = var.ingress_rules

  from_port         = each.value.from_port
  protocol          = each.value.protocol
  to_port           = each.value.to_port
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  cidr_blocks       = each.value.cidr_blocks
}
