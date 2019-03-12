
/******
Bastion instance
*********/
resource "aws_instance" "jenkins" {
  ami                         = "ami-02da3a138888ced85"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.ecs_key_pair_name}"
  associate_public_ip_address = "true"
  subnet_id                   = "${element(var.public_subnetsp, 0)}"
  private_ip                  = "11.0.1.109"
  security_groups             =  ["${var.sg_LB}"]
   tags = {
    Name = "vane-bastion"
  }
  ##--------saltconfig file
  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("DanielaCelis.pem")}"
      host        = "${aws_instance.jenkins.public_ip}"
    }

    source      = "./Scripts/saltconfig/Saltconfig.sh"
    destination = "/home/ec2-user/Saltconfig.sh"
  }

  ##-----------jenkins file
  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("DanielaCelis.pem")}"
      host        = "${aws_instance.jenkins.public_ip}"
    }

    source      = "./Scripts/jenkins/jenkins_installation.sls"
    destination = "/home/ec2-user/jenkins_installation.sls"
  }

  ##-----------jenkins file
  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("DanielaCelis.pem")}"
      host        = "${aws_instance.jenkins.public_ip}"
    }

    source      = "./Scripts/jenkins/jenkins.sls"
    destination = "/home/ec2-user/jenkins.sls"
  }

  ##-----------jenkins file
  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("DanielaCelis.pem")}"
      host        = "${aws_instance.jenkins.public_ip}"
    }

    source      = "./Scripts/jenkins/top.sls"
    destination = "/home/ec2-user/top.sls"
  }

  ##-----------jenkins file
  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("DanielaCelis.pem")}"
      host        = "${aws_instance.jenkins.public_ip}"
    }

    source      = "./Scripts/jenkins/master"
    destination = "/home/ec2-user/master"
  }

 ##-----------docker installation file
  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("DanielaCelis.pem")}"
      host        = "${aws_instance.jenkins.public_ip}"
    }

    source      = "./Scripts/docker/docker_installation.sls"
    destination = "/home/ec2-user/docker_installation.sls"
  }

##-----------docker installation file
  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("DanielaCelis.pem")}"
      host        = "${aws_instance.jenkins.public_ip}"
    }

    source      = "./Scripts/git/git_installation.sls"
    destination = "/home/ec2-user/git_installation.sls"
  }

  ##--------remote-exec file
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${file("DanielaCelis.pem")}"
      host        = "${aws_instance.jenkins.public_ip}"
    }

    # script = "${file("./Scripts/saltconfig/remote-exec.sh")}"
    inline = [
      "sudo sh Saltconfig.sh",
      "sudo rm /etc/salt/minion",
      "sudo rm /etc/salt/master",
      "sudo echo 'interface: 0.0.0.0' | sudo tee /etc/salt/master",
      "sudo echo 'master: 11.0.1.109' | sudo tee /etc/salt/minion",
      "sudo systemctl restart salt-minion",
      "sudo systemctl restart salt-master",
      "sudo yum install git -y",
      "sudo mkdir -p /srv/salt /srv/formulas /srv/pillar",
      "sudo mv jenkins_installation.sls top.sls /srv/salt/",
      "cd /srv/formulas && sudo git clone https://github.com/saltstack-formulas/jenkins-formula.git",
      "sudo rm /etc/salt/master",
      "sudo mv /home/ec2-user/master /etc/salt/",
      "sudo mv /home/ec2-user/jenkins.sls /srv/pillar/",
      "sudo salt-key -L",
      "sudo salt-key -A -y",
      #"sudo mv docker_installation.sls git_installation.sls /srv/salt/",
    ]
  }
}
