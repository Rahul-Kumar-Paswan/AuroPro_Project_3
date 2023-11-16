resource "aws_instance" "my_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  tags = {
    Name = var.instance_name
  }
  vpc_security_group_ids = [
    aws_security_group.my_security_group.id
  ]

  associate_public_ip_address = true
  key_name = aws_key_pair.ssh-key.key_name  # Associate the key pair with the instance

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",  # Installing Docker
      # Additional commands for Docker setup or container deployment can be added here
    ]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user" # Replace with the username for your AMI
    private_key = file(var.private_key_path) # Add the path to your private key
    host        = self.public_ip # You can use `self.public_dns` as well
  }
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "my-key"
  public_key = file("~/.ssh/my-key.pub")
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

  ingress {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }


  ingress {
    from_port   = 2375
    to_port     = 2375
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with the appropriate IP range for your MySQL server
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
