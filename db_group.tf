resource "aws_db_subnet_group" "default" {
  count      = "${var.rds ? 1 : 0}"
  name       = "RDS"
  subnet_ids = ["${aws_subnet.private_rds_1}","${aws_subnet.private_rds_2}"]
}