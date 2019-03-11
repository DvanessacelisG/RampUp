/*resource "aws_lb" "ecs-load-balancer" {
  name    = "vane-ecs-load-balancer"
  subnets = ["${var.public_subnetsp}"]

  tags {
    Name = "vane-ecs-load-balancer"
  }
}

resource "aws_lb_target_group" "ecs-target-group" {
  name     = "vane-ecs-target-group"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_name}"

  tags {
    Name = "vane-ecs-target-group"
  }
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = "${aws_lb.ecs-load-balancer.arn}"
  count             = "${length(var.port_lb)}"
  port              = "${element(var.port_lb, count.index)}"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.ecs-target-group.arn}"
    type             = "forward"
  }
}


*/