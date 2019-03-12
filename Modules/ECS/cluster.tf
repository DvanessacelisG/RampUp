/*====
ECS cluster
======*/
resource "aws_ecs_cluster" "Vane_cluster" {
  name = "${var.ECS_cluster}"
}
