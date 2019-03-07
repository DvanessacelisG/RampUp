
resource "aws_nat_gateway" "gw" {
  allocation_id = "${data.aws_eip.OV_EIP.id}"
  subnet_id     = "${aws_subnet.public_subnet.0.id}"

  tags = {
    Name = "vane-gw-NAT"
  }
}