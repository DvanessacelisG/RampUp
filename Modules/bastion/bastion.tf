resource "aws_instance" "jenkins" {
  ami                         = "ami-02da3a138888ced85"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.ecs_key_pair_name}"
  associate_public_ip_address = "true"
  subnet_id                   = "${element(var.public_subnetsp, 0)}"
  private_ip                  = "11.0.1.109"

}