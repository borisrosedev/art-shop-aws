resource "aws_subnet" "frontend_subnet" {
  count             = length(var.frontend_subnet_cidrs)
  vpc_id            = var.vpc_id
  cidr_block        = element(var.frontend_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Frontend Subnet ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "frontend_igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "Frontend IGW"
  }
}

resource "aws_route_table" "frontend_route_table" {
  count  = length(var.frontend_subnet_cidrs)
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.frontend_igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.frontend_igw.id
  }

  tags = {
    Name = "Frontend Route Table ${count.index + 1}"
  }
}

resource "aws_route_table_association" "frontend_route_association" {
  count          = length(var.frontend_subnet_cidrs)
  subnet_id      = aws_subnet.frontend_subnet[count.index].id
  route_table_id = aws_route_table.frontend_route_table[count.index].id
}

resource "aws_security_group" "frontend_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
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
    Name = "Frontend SG"
  }
}

resource "aws_key_pair" "frontend_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "frontend_instance" {
  count                     = length(var.frontend_subnet_cidrs)
  ami                       = var.vm_ami
  instance_type             = var.instance_type
  subnet_id                 = aws_subnet.frontend_subnet[count.index].id
  associate_public_ip_address = true
  key_name                  = aws_key_pair.frontend_key.key_name
  security_groups           = [aws_security_group.frontend_sg.id]
  user_data                 = file("${path.module}/user-data.sh")

  depends_on = [aws_internet_gateway.frontend_igw]

  tags = {
    Name = "Frontend Instance ${count.index + 1}"
  }
}

