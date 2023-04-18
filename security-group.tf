resource "aws_security_group" "one" {
    name = "${var.name}-SG"
    vpc_id = aws_vpc.test.id
    tags = {
      "name" : "${var.name}-SG"
    }
}

resource "aws_security_group_rule" "rulesA" {
  security_group_id = aws_security_group.one.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "rulesB" {
  security_group_id = aws_security_group.one.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

