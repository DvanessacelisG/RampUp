data "aws_internet_gateway" "OV_IG" {
  filter {
    name   = "tag:Name"
    values = ["OV_IG"]
  }
}