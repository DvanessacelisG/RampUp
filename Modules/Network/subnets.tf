/* Public subnets */
resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.Vane_VPC.id}"
  count                   = "${length(var.public_subnets_cidr)}"
  cidr_block              = "${element(var.public_subnets_cidr, count.index)}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name      = "Vane-${element(var.availability_zones, count.index)}-public-subnet"
    create_by = "Vanessa celis"
  }
}

/* Private subnet */
resource "aws_subnet" "private_subnet" {
  vpc_id            = "${aws_vpc.Vane_VPC.id}"
  count             = "${length(var.private_subnet_cidr)}"
  cidr_block        = "${element(var.private_subnet_cidr, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  #map_public_ip_on_launch = false

  tags {
    Name      = "Vane-${element(var.availability_zones, count.index)}-private-subnet"
    create_by = "Vanessa celis"
  }
}
