/*===============
       VPC
================*/
/*data "aws_vpc" "OV_VPC" {
  filter {
    name   = "tag:Name"
    values = ["OV_VPC"]
  }
}
*/

resource "aws_vpc" "Vane_VPC" {
  cidr_block = "11.0.0.0/16"

  tags = {
    Name = "Vane_vpc"
  }
}
