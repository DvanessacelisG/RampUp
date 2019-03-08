
data "aws_ami" "ecs_ami" {

 owners = ["amazon"]
 most_recent = true

 filter {
   name   = "name"
   values = ["amzn-ami-*-amazon-ecs-optimized"]
 }
}
resource "aws_launch_configuration" "ecs-launch-configuration" {
  name                 = "vane-ecs-launch-configuration"
  image_id             = "${data.aws_ami.ecs_ami.id}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs-instance-profile.id}"
  root_block_device {
    volume_type           = "standard"
    volume_size           = 50
    delete_on_termination = true
  }
  lifecycle {
    create_before_destroy = true
  }
  associate_public_ip_address = "true"
  key_name                    = "${var.ecs_key_pair_name}"
  user_data = "${file("./Modules/ECS/cluster.sh")}"
    
}
resource "aws_instance" "jenkins" {
  ami                         = "${var.ecs_aws_ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.ecs_key_pair_name}"
  associate_public_ip_address = "true"
  subnet_id                   = "${element(var.public_subnetsp, 0)}"
  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("VanessaCelis.pem")}"
      host        = "${aws_instance.jenkins.public_ip}"
    }
    source      = "Saltconfig.sh"
    destination = "/home/ubuntu/Saltconfig.sh"
  }
  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("VanessaCelis.pem")}"
      host        = "${aws_instance.jenkins.public_ip}"
    }
    source      = "mm.sh"
    destination = "/home/ubuntu/mm.sh"
  }
}
