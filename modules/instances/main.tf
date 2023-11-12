resource "aws_instance" "my_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  tags = {
    Name = var.instance_name
  }
  vpc_security_group_ids = [
    aws_security_group.my_security_group.id,
  ]
}

resource "aws_security_group" "my_security_group" {
  name_prefix   = "${var.env_prefix}-security-group"
  description   = "Allow traffic on specified ports"
  vpc_id        = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }

  tags = {
    Name = "${var.env_prefix}-security-group"
  }
}
