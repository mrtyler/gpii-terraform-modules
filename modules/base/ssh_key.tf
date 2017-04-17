resource "aws_key_pair" "main" {
  key_name = "${var.ssh_key_name}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCneeAqx4N2yjwHNKlGg80Iqpdo9kmZtdTMt40c6r01M7hx+h2KTeHQ7QF4xdYHvcdKDcInwiAafnJyseHEjiDWyEhnJzyVkUg2Td9ff2cd+JioLpDoXg/bTzjL4ReJJkiUSgRwRUQA+gB22TpODeIIMMdDkpXjA/SsKO7qY9V7U5+VGhVFxrTnzqlcvUC7B3Pz6QwxvfeAJy1Sc5I1NlOdRcRbShCpkkQwIJE3ofXifucS+REa42rJ/2iKGFDqLlacY2GD1RtmrLEZ4kN1ngaQRSfqv6ayZsJrExsYU2tuWKT8RwNUtL/kbaJVFzS+Jl+dXAnv8QhGhsphbYNreJtl gpii-key.pem"
}