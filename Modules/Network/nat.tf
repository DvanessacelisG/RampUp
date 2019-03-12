resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.Vane_eip.id}"
  subnet_id     = "${aws_subnet.public_subnet.0.id}"

  tags = {
    Name = "vane-gw-NAT"
  }
}
