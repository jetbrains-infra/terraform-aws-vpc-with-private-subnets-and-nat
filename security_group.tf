resource "aws_security_group" "access_via_nat" {
  count = "${local.nat_instance ? 1 : 0}"
  name = "Access to nat instance"
  description = "Access to internet via nat instance for private nodes"
  vpc_id = "${aws_vpc.project.id}"

  # outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "allow_inbound_traffic_1" {
  count = "${local.nat_instance ? 1 : 0}"
  type = "ingress"
  from_port = 0
  to_port = 65535
  protocol = "all"
  cidr_blocks = ["${aws_subnet.private_app_1.cidr_block}"]
  security_group_id = "${aws_security_group.access_via_nat.id}"
}

resource "aws_security_group_rule" "allow_inbound_traffic_2" {
  count = "${local.nat_instance_multi_az ? 1 : 0}"
  type = "ingress"
  from_port = 0
  to_port = 65535
  protocol = "all"
  cidr_blocks = ["${aws_subnet.private_app_2.cidr_block}"]
  security_group_id = "${aws_security_group.access_via_nat.id}"
}