resource "aws_autoscaling_group" "ecs-autoscaling-group-front" {
  name                 = "vane-ecs-autoscaling-group-front"
  max_size             = "5"
  min_size             = "3"
  vpc_zone_identifier  = ["${var.public_subnetsp}"]
  launch_configuration = "${aws_launch_configuration.ecs-launch-configuration.name}"
  health_check_type    = "EC2"
  target_group_arns     = ["${aws_lb_target_group.ecs-target-group.arn}"]
  tags {
    key="Name"
    value="Vane-frontend"
    propagate_at_launch= true
  }
}

resource "aws_autoscaling_group" "ecs-autoscaling-group-back" {
  name                 = "vane-ecs-autoscaling-group-back"
  max_size             = "5"
  min_size             = "3"
  vpc_zone_identifier  = ["${var.private_subnetsp}"]
  launch_configuration = "${aws_launch_configuration.ecs-launch-configuration.name}"
  health_check_type    = "EC2"
    tags {
    key="Name"
    value="Vane-backend"
    propagate_at_launch= true
  }
}