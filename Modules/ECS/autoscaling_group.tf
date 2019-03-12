resource "aws_autoscaling_group" "ecs-autoscaling-group-front" {
  name                 = "vane-ecs-autoscaling-group-front"
  max_size             = "2"
  min_size             = "1"
  vpc_zone_identifier  = ["${element(var.private_subnetsp, 1)}", "${element(var.private_subnetsp, 2)}"]
  launch_configuration = "${aws_launch_configuration.ecs-launch-configuration.name}"
  health_check_type    = "EC2"

  target_group_arns    = ["${aws_lb_target_group.extern-target-group.arn}"]

  tags {
    key                 = "Name"
    value               = "Vane-frontend"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "ecs-autoscaling-group-back" {
  name                 = "vane-ecs-autoscaling-group-back"
  max_size             = "5"
  min_size             = "1"
  vpc_zone_identifier  = ["${element(var.private_subnetsp,2)}"]
  launch_configuration = "${aws_launch_configuration.ecs-launch-configuration.name}"
  health_check_type    = "EC2"

  target_group_arns    = ["${aws_lb_target_group.int-target-group.arn}"]
  tags {
    key                 = "Name"
    value               = "Vane-backend"
    propagate_at_launch = true
  }
}
