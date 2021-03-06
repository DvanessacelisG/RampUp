/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = "${data.aws_vpc.OV_VPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${data.aws_internet_gateway.OV_IG.id}"
  }

  tags {
    Name = "Vane-private-route-table"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = "${data.aws_vpc.OV_VPC.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${data.aws_internet_gateway.OV_IG.id}"
  }

  tags {
    Name = "Vane-public-route-table"
  }
}

resource "aws_route_table_association" "public-route" {
  count          = "${length(var.public_subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private-route" {
  count          = "${length(var.private_subnet_cidr)}"
  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}
