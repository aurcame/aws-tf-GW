// Create custom Security Group
resource "aws_security_group" "GW-ssh" {
  name        = "GW_ssh_sg"
  description = "Allow SSH from my IP only"
  vpc_id      = aws_vpc.GW-VPC.id

  // rules below
  ingress {
    description = "SSH from my IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["93.74.141.207/32"]
    //    cidr_blocks = [aws_vpc.GW-VPC.cidr_block]
  }

  ingress {
    description = "SSH inside VPC only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.GW-VPC.cidr_block]
  }

  ingress {
    description = "HTTP to all"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Jenkins port 8080
  ingress {
    description = "SSH from my IP only"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["93.74.141.207/32"]
    //    cidr_blocks = [aws_vpc.GW-VPC.cidr_block]
  }

  // Nexus port 8081
  ingress {
    description = "SSH from my IP only"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["93.74.141.207/32"]
    //    cidr_blocks = [aws_vpc.GW-VPC.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "GW SSH SG"
    project = "GW"
    name    = "GW SSH SG"
  }
}
