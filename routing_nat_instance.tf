# allow internet access to Application nodes through nat #1
resource "aws_route_table" "nat_instance_1" {
  count  = "${local.nat_instance ? 1 : 0}"
  vpc_id = "${aws_vpc.project.id}"

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_instance.nat_1.id}"
  }

  tags {
    Name = "Application to Internet through Nat instance #1"
  }
}
resource "aws_route_table_association" "app_1_subnet_to_nat_instance" {
  count          = "${local.nat_instance ? 1 : 0}"
  route_table_id = "${aws_route_table.nat_instance_1.id}"
  subnet_id      = "${aws_subnet.private_app_1.id}"
}

# allow internet access to Application nodes through nat #2
resource "aws_route_table" "nat_instance_2" {
  count = "${local.nat_instance_multi_az ? 1 : 0}"
  vpc_id = "${aws_vpc.project.id}"

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_nat_gateway.nat_2.id}"
  }

  tags {
    Name = "Application to Internet through Nat instance #2"
  }
}
resource "aws_route_table_association" "app_2_subnet_to_nat_instance" {
  count = "${local.nat_instance_multi_az ? 1 : 0}"
  route_table_id = "${aws_route_table.nat_instance_2.id}"
  subnet_id = "${aws_subnet.private_app_2.id}"
}