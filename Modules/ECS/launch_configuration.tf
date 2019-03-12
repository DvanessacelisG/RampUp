data "aws_ami" "ecs_ami" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }
}

resource "aws_launch_configuration" "ecs-launch-configuration" {
  name = "vane-ecs-launch-configuration"

  #image_id             = "${data.aws_ami.ecs_ami.id}"
  image_id             = "ami-055c44a99d4f38e95"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs-instance-profile.id}"
  security_groups      = ["${var.sg_LB}"]

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
                                  sudo yum install salt-minion -y;
                                  echo ECS_CLUSTER=${var.ECS_cluster} >> /etc/ecs/ecs.config;
                                  sudo rm /etc/salt/minion;
                                  sudo echo 'master: 11.0.1.109' | sudo tee /etc/salt/minion;
                                  sudo systemctl restart salt-minion;
                                  EOF
}
