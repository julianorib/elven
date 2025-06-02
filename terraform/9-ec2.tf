## Criar a Instância docker
resource "aws_instance" "docker" {
  ami             = data.aws_ami.amzn-linux-2023-ami.id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.main.key_name
  subnet_id       = aws_subnet.private-1a.id
  security_groups = [aws_security_group.acesso-out-internet.id, aws_security_group.acesso-in-ssh.id, aws_security_group.acesso-in-web.id]

  tags = merge({ Name = format("%s-ec2", var.project_name) }, local.common_tags)
}


## Criar a Instância pritunl
resource "aws_instance" "pritunl" {
  ami             = data.aws_ami.amzn-linux-2023-ami.id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.main.key_name
  subnet_id       = aws_subnet.public-1a.id
  security_groups = [aws_security_group.acesso-out-internet.id, aws_security_group.acesso-in-ssh.id, aws_security_group.acesso-in-web.id]

  tags = merge({ Name = format("%s-ec2", var.project_name) }, local.common_tags)
}

