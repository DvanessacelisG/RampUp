data "aws_eip" "OV_EIP" {
  filter {
    name   = "tag:Name"
    values = ["OV_EIP"]
  }
}
