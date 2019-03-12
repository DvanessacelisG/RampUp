output "vpc_id" {
  value = "${aws_vpc.Vane_VPC.id}"
}

output "public_subnets_id" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}

output "private_subnet_id" {
  value = ["${aws_subnet.private_subnet.*.id}"]
}

output "sg_lb_id" {
  value = "${aws_security_group.sg_lb_Front.id}"
}
