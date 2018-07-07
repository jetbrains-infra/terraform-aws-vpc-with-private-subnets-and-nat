# allow internet access to nat #1
resource "aws_route_table" "public_1_to_internet" {
  vpc_id = "${aws_vpc.project.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "Public net #1 to Internet"
  }
}
resource "aws_route_table_association" "internet_for_public_1" {
  route_table_id = "${aws_route_table.public_1_to_internet.id}"
  subnet_id      = "${aws_subnet.public_nat_1.id}"
}

# allow internet access to nat #2
resource "aws_route_table" "public_2_to_internet" {
  vpc_id = "${aws_vpc.project.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "Nat #2 to Internet"
  }
}
resource "aws_route_table_association" "internet_for_public_2" {
  count = "${var.multi_az ? 1 : 0}"
  route_table_id = "${aws_route_table.public_2_to_internet.id}"
  subnet_id = "${aws_subnet.public_nat_2.id}"
}