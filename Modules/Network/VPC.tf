/*===============
       VPC
================*/
data "aws_vpc" "OV_VPC" {
  filter {
    name   = "tag:Name"
    values = ["OV_VPC"]
  }
}
