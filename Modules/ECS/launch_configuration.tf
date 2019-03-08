resource "aws_launch_configuration" "ecs-launch-configuration" {
  name                 = "vane-ecs-launch-configuration"
  image_id             = "${var.ecs_aws_ami}"
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

  user_data = <<EOF
            #!/bin/bash
            echo "ECS_CLUSTER=vane-${var.ECS_cluster}" >> /etc/ecs/ecs.config
            EOF
}

resource "aws_instance" "jenkins" {
  ami                         = "${var.ecs_aws_ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.ecs_key_pair_name}"
  associate_public_ip_address = "true"
  subnet_id                   = "${element(var.public_subnetsp, 0)}"


  provisioner "remote-exec" {
    connection {
            type     = "ssh"
            user     = "ubuntu"
            private_key = "${file("./Modules/ECS/VanessaCelis.pem")}"
            host     = "${aws_instance.jenkins.public_ip}"
          }
    inline = ["sudo chown -R ubuntu: /etc"]  
  }
  provisioner "file" {
    source      = "Modules/ECS/config.sh"
    destination = "/config.sh"
    }

 /*provisioner "remote-exec" {
    command = "echo ${aws_instance.jenkins.public_ip} >> public_ip.txt"
  }*/

}
