resource "aws_instance" "main" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  subnet_id = "${aws_subnet.main.id}"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.main.id}"]
  tags {
    Name = "main"
    # For use by ansible via terraform-inventory
    Group = "aws_gpii_ci_docker"
  }

  provisioner "remote-exec" {
    inline = [
      # kitchen runs sudo without a tty and gets this error:
      #
      # Failed to complete #verify action: [Sudo failed: Sudo requires a TTY.
      # Please see the README on how to configure sudo to allow for
      # non-interactive usage.] on default-centos
      #
      # I don't see a way to pass "-t" through kitchen or terraform so this is
      # a workaround.
      "sudo sed -i /etc/sudoers -e 's/Defaults    requiretty/Defaults    !requiretty/g'",
      # docker is for doing docker things, like running docker containers.
      # docker-py is for ansible to interact with docker.
      "sudo yum install -y docker python-docker-py",
      # Something is weird with the docker package and selinux. See e.g.
      # https://github.com/docker/docker/issues/30097.
      #
      # For now, just disable selinux :(.
      "sudo setenforce permissive",
      "sudo systemctl start docker",
    ]
    connection {
      user = "centos"
    }
  }
}

# Disabled for now because terraform-inventory discovers the wrong (original)
# public ip after this elastic ip is attached.
# resource "aws_eip" "main_instance" {
#   #instance = "${aws_instance.main.id}"
#   vpc = true
# }