/*====
ECS cluster
======*/
resource "aws_ecs_cluster" "Vane_cluster" {
  name = "vane-${var.ECS_cluster}"
}
