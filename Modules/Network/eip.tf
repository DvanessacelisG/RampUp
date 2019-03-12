/*data "aws_eip" "OV_EIP" {
  filter {
    name   = "tag:Name"
    values = ["OV_EIP"]
  }
}
*/

resource "aws_eip" "Vane_eip" {
  vpc = true

  tags = {
    Name = "Vane_eip"
  }
}
