# allow internet access to nat #1
resource "aws_route_table" "nat_1" {
  vpc_id = "${aws_vpc.project.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "Nat #1 to Internet"
  }
}
resource "aws_route_table_association" "nat_1_subnet" {
  route_table_id = "${aws_route_table.nat_1.id}"
  subnet_id = "${aws_subnet.public_nat_1.id}"
}

# allow internet access to Application nodes through nat #1
resource "aws_route_table" "private_1" {
  vpc_id = "${aws_vpc.project.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_1.id}"
  }

  tags {
    Name = "Application to Internet through Nat #1"
  }
}
resource "aws_route_table_association" "app_1_subnet" {
  route_table_id = "${aws_route_table.private_1.id}"
  subnet_id = "${aws_subnet.private_app_1.id}"
}

# allow internet access to nat #2
resource "aws_route_table" "nat_2" {
  count = "${var.multi_az ? 1 : 0}"
  vpc_id = "${aws_vpc.project.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "Nat #2 to Internet"
  }
}
resource "aws_route_table_association" "nat_2_subnet" {
  count = "${var.multi_az ? 1 : 0}"
  route_table_id = "${aws_route_table.nat_2.id}"
  subnet_id = "${aws_subnet.public_nat_2.id}"
}

# allow internet access to Application nodes through nat #2
resource "aws_route_table" "private_2" {
  count = "${var.multi_az ? 1 : 0}"
  vpc_id = "${aws_vpc.project.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_2.id}"
  }

  tags {
    Name = "Application to Internet through Nat #2"
  }
}
resource "aws_route_table_association" "app_2_subnet" {
  count = "${var.multi_az ? 1 : 0}"
  route_table_id = "${aws_route_table.private_2.id}"
  subnet_id = "${aws_subnet.private_app_2.id}"
}