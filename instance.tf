resource "aws_instance" "Altschool1" {
  ami               = "ami-0778521d914d23bc1"
  instance_type     = "t2.micro"
  key_name          = "columbo"
  security_groups   = [aws_security_group.Altschool-security-grp-rule.id]
  subnet_id         = aws_subnet.Altschool-public-subnet1.id
  availability_zone = "us-east-1a"
  tags = {
    Name   = "Altschool-1"
    source = "terraform"
  }
}
# creating instance 2
resource "aws_instance" "Altschool2" {
  ami               = "ami-0778521d914d23bc1"
  instance_type     = "t2.micro"
  key_name          = "columbo"
  security_groups   = [aws_security_group.Altschool-security-grp-rule.id]
  subnet_id         = aws_subnet.Altschool-public-subnet2.id
  availability_zone = "us-east-1b"
  tags = {
    Name   = "Altschool-2"
    source = "terraform"
  }
}
# creating instance 3
resource "aws_instance" "Altschool3" {
  ami               = "ami-0778521d914d23bc1"
  instance_type     = "t2.micro"
  key_name          = "columbo"
  security_groups   = [aws_security_group.Altschool-security-grp-rule.id]
  subnet_id         = aws_subnet.Altschool-public-subnet1.id
  availability_zone = "us-east-1a"
  tags = {
    Name   = "Altschool-3"
    source = "terraform"
  }
}

resource "local_file" "Ip_address" {
  filename = "./host-inventory"
  content  = <<EOT
${aws_instance.Altschool1.public_ip}
${aws_instance.Altschool2.public_ip}
${aws_instance.Altschool3.public_ip}
  EOT
}
