// new ssh key pair definition
// already have ssh key attached in AWS account so comment this
/* resource "aws_key_pair" "awskey" {
  key_name   = "awskey-frankfurt"
  public_key = var.public_key
}
*/

###
#  Create 5 EC2 instances: Ansible, DevTools, CI, QA, Docker:
###

// DevTools server Network interface to set known IP address
resource "aws_network_interface" "GW-Ansible-NI" {
  description     = "GW Ansible NI"
  subnet_id       = aws_subnet.GW-subnet1.id
  private_ips     = ["10.0.1.111"]
  security_groups = [aws_security_group.GW-ssh.id]

  /*attachment {
    instance     = aws_instance.GW-Ansible.id
    device_index = 0
  }
*/

  tags = {
    Name    = "0 Ansible NI"
    project = "GW"
    name    = "GW Ansible NI"
  }

  depends_on = [aws_subnet.GW-subnet1]
}

// Ansible server instance
resource "aws_instance" "GW-Ansible" {
  ami           = var.ec2ami
  instance_type = var.instance_type
  key_name      = "awskey-frankfurt"
  //key_name      = aws_key_pair.awskey.key_name
  //subnet_id = aws_subnet.GW-subnet1.id

  network_interface {
    network_interface_id = aws_network_interface.GW-Ansible-NI.id
    device_index         = 0
  }

  // startup script
  user_data = file("userdata/Ansible.sh")

  tags = {
    Name    = "0 Ansible"
    project = "GW"
    name    = "GW Ansible instance"
  }
  volume_tags = {
    project = "GW"
    name    = "GW Ansible volume"
  }

  depends_on = [aws_subnet.GW-subnet1, aws_internet_gateway.GW-IGW]
}

// DevTools server Network interface to set known IP address
resource "aws_network_interface" "GW-DevTools-NI" {
  description     = "GW DevTools NI"
  subnet_id       = aws_subnet.GW-subnet1.id
  private_ips     = ["10.0.1.101"]
  security_groups = [aws_security_group.GW-ssh.id]

  /*attachment {
    instance     = aws_instance.GW-DevTools.id
    device_index = 0
  }
*/

  tags = {
    Name    = "1 DevTools NI"
    project = "GW"
    name    = "GW DevTools NI"
  }

  depends_on = [aws_subnet.GW-subnet1]
}

// DevTools server instance
resource "aws_instance" "GWDevTools" {
  ami           = var.ec2ami
  instance_type = var.instance_type
  key_name      = "awskey-frankfurt"
  //key_name      = aws_key_pair.awskey.key_name
  //subnet_id = aws_subnet.GW-subnet1.id

  network_interface {
    network_interface_id = aws_network_interface.GW-DevTools-NI.id
    device_index         = 0
  }

  // startup script
  user_data = file("userdata/DevTools.sh")

  tags = {
    Name    = "1 DevTools"
    project = "GW"
    name    = "GW DevTools instance"
  }
  volume_tags = {
    project = "GW"
    name    = "GW DevTools volume"
  }

  depends_on = [aws_subnet.GW-subnet1, aws_internet_gateway.GW-IGW]
}


// CI server Network interface to set known IP address
resource "aws_network_interface" "GW-CI-NI" {
  description     = "GW CI NI"
  subnet_id       = aws_subnet.GW-subnet1.id
  private_ips     = ["10.0.1.102"]
  security_groups = [aws_security_group.GW-ssh.id]

  /*attachment {
    instance     = aws_instance.GW-CI.id
    device_index = 0
  }
*/

  tags = {
    Name    = "2 CI NI"
    project = "GW"
    name    = "GW CI NI"
  }

  depends_on = [aws_subnet.GW-subnet1]
}

// CI server instance
resource "aws_instance" "GW-CI" {
  ami           = var.ec2ami
  instance_type = var.instance_type
  key_name      = "awskey-frankfurt"
  //key_name      = aws_key_pair.awskey.key_name
  //subnet_id = aws_subnet.GW-subnet1.id

  network_interface {
    network_interface_id = aws_network_interface.GW-CI-NI.id
    device_index         = 0
  }

  // startup script
  user_data = file("userdata/CI.sh")

  tags = {
    Name    = "2 CI"
    project = "GW"
    name    = "GW CI instance"
  }
  volume_tags = {
    project = "GW"
    name    = "GW CI volume"
  }

  depends_on = [aws_vpc.GW-VPC, aws_subnet.GW-subnet1, aws_internet_gateway.GW-IGW]
}

// CI server Network interface to set known IP address
resource "aws_network_interface" "GW-QA-NI" {
  description     = "GW QA NI"
  subnet_id       = aws_subnet.GW-subnet1.id
  private_ips     = ["10.0.1.103"]
  security_groups = [aws_security_group.GW-ssh.id]

  /*attachment {
    instance     = aws_instance.GW-QA.id
    device_index = 0
  }
*/

  tags = {
    Name    = "3 QA NI"
    project = "GW"
    name    = "GW QA NI"
  }

  depends_on = [aws_subnet.GW-subnet1]
}

// QA server instance
resource "aws_instance" "GW-QA" {
  ami           = var.ec2ami
  instance_type = var.instance_type
  key_name      = "awskey-frankfurt"
  //  key_name      = aws_key_pair.awskey.key_name
  //subnet_id = aws_subnet.GW-subnet1.id

  network_interface {
    network_interface_id = aws_network_interface.GW-QA-NI.id
    device_index         = 0
  }

  // startup script
  user_data = file("userdata/QA.sh")

  tags = {
    Name    = "3 QA"
    project = "GW"
    name    = "GW QA instance"
  }
  volume_tags = {
    project = "GW"
    name    = "GW QA volume"
  }

  depends_on = [aws_vpc.GW-VPC, aws_subnet.GW-subnet1, aws_internet_gateway.GW-IGW]
}

// Docker server Network interface for known IP address
resource "aws_network_interface" "GW-Docker-NI" {
  description     = "GW Docker NI"
  subnet_id       = aws_subnet.GW-subnet1.id
  private_ips     = ["10.0.1.104"]
  security_groups = [aws_security_group.GW-ssh.id]

  /*attachment {
    instance     = aws_instance.GW-Docker.id
    device_index = 0
  }
*/
  tags = {
    Name    = "4 Docker NI"
    project = "GW"
    name    = "GW Docker NI"
  }

  depends_on = [aws_subnet.GW-subnet1]
}

// Docker server
resource "aws_instance" "GW-Docker" {
  ami           = var.ec2ami
  instance_type = var.instance_type
  key_name      = "awskey-frankfurt"
  //  key_name      = aws_key_pair.awskey.key_name
  //subnet_id = aws_subnet.GW-subnet1.id

  network_interface {
    network_interface_id = aws_network_interface.GW-Docker-NI.id
    device_index         = 0
  }

  // startup script
  user_data = file("userdata/Docker.sh")

  tags = {
    Name    = "4 Docker"
    project = "GW"
    name    = "GW Docker instance"
  }
  volume_tags = {
    project = "GW"
    name    = "GW Docker volume"
  }

  depends_on = [aws_vpc.GW-VPC, aws_subnet.GW-subnet1, aws_internet_gateway.GW-IGW]
}
