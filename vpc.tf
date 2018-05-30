resource "aws_vpc" "project" {
  cidr_block = "10.0.0.0/22"

  tags {
    Name = "${var.project}"
  }
}
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.project.id}"
}