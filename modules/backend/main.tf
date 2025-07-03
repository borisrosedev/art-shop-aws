# Création des subnets backend
resource "aws_subnet" "backend_subnet" {
  count             = length(var.backend_subnet_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = var.backend_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "Backend Subnet ${count.index + 1}"
  }
}

# Création d'un groupe de sécurité backend
resource "aws_security_group" "backend_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Backend Security Group"
  }
}

# Instances EC2 backend
resource "aws_instance" "backend_instance" {
  count                     = length(var.backend_subnet_cidrs)
  subnet_id                 = aws_subnet.backend_subnet[count.index].id
  instance_type             = var.instance_type
  ami                       = var.vm_ami
  key_name                  = var.key_name
  associate_public_ip_address = true
  security_groups           = [aws_security_group.backend_sg.id]

  tags = {
    Name = "Backend Instance ${count.index + 1}"
  }
}
