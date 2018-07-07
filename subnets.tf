# public subnet #1 for NAT gw
resource "aws_subnet" "public_nat_1" {
  cidr_block = "10.0.0.0/28"
  vpc_id = "${aws_vpc.project.id}"
  availability_zone = "eu-west-1b"

  tags {
    Name = "Nat #1"
    Visibility = "Private"
  }
}

# public subnet #2 for NAT gw
resource "aws_subnet" "public_nat_2" {
  cidr_block = "10.0.0.16/28"
  vpc_id = "${aws_vpc.project.id}"
  availability_zone = "eu-west-1c"

  tags {
    Name = "Nat #2"
    Visibility = "Private"
  }
}

# private subnet #1 for RDS
resource "aws_subnet" "private_rds_1" {
  count = "${var.rds ? 1 : 0 }"
  cidr_block = "10.0.0.32/27"
  vpc_id = "${aws_vpc.project.id}"
  availability_zone = "eu-west-1b"

  tags {
    Name = "RDS #1"
    Visibility = "Private"
  }
}

# private subnet #2 for RDS
resource "aws_subnet" "private_rds_2" {
  count = "${var.rds ? 1 : 0 }"
  cidr_block = "10.0.0.64/27"
  vpc_id = "${aws_vpc.project.id}"
  availability_zone = "eu-west-1c"

  tags {
    Name = "RDS #2"
    Visibility = "Private"
  }
}

# private subnet #1
resource "aws_subnet" "private_app_1" {
  cidr_block = "10.0.1.0/24"
  vpc_id = "${aws_vpc.project.id}"
  availability_zone = "eu-west-1b"

  tags {
    Name = "App #1"
    Visibility = "Private"
  }
}

# private subnet #2
resource "aws_subnet" "private_app_2" {
  count = "${var.multi_az ? 1 : 0}"

  cidr_block = "10.0.2.0/24"
  vpc_id = "${aws_vpc.project.id}"
  availability_zone = "eu-west-1c"

  tags {
    Name = "App #2"
    Visibility = "Private"
  }
}
