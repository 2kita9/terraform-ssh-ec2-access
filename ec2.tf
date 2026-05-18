data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-qxgoe9r5-vpc"]
  }
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }
}

data "aws_security_group" "ssh_sg" {
  filter {
    name   = "group-name"
    values = ["cmtr-qxgoe9r5-sg"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = data.aws_subnets.public_subnets.ids[0]
  vpc_security_group_ids      = [data.aws_security_group.ssh_sg.id]
  key_name                    = aws_key_pair.keypair.key_name
  associate_public_ip_address = true

  tags = {
    Name    = "cmtr-qxgoe9r5-ec2"
    Project = "epam-tf-lab"
    ID      = "cmtr-qxgoe9r5"
  }
}