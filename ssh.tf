resource "aws_key_pair" "keypair" {
  key_name   = "cmtr-qxgoe9r5-keypair"
  public_key = var.ssh_key

  tags = {
    Project = "epam-tf-lab"
    ID      = "cmtr-qxgoe9r5"
  }
}