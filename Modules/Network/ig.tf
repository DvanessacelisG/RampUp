/*data "aws_internet_gateway" "OV_IG" {
  filter {
    name   = "tag:Name"
    values = ["OV_IG"]
  }
}
*/

resource "aws_internet_gateway" "Vane_gw" {
  vpc_id = "${aws_vpc.Vane_VPC.id}"

  tags = {
    Name = "Vane_gw"
  }
}
