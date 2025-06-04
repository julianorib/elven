## Criar a Instância docker
resource "aws_instance" "docker" {
  ami             = data.aws_ami.amzn-linux-2023-ami.id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.main.key_name
  subnet_id       = aws_subnet.private-1a.id
  security_groups = [aws_security_group.linux.id]
  user_data       = filebase64("${path.module}/docker.sh")
  tags            = merge({ Name = format("%s-ec2-docker", var.project_name) }, local.common_tags)
}


## Criar a Instância pritunl
resource "aws_instance" "pritunl" {
  ami                         = data.aws_ami.amzn-linux-2023-ami.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.main.key_name
  subnet_id                   = aws_subnet.public-1a.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.linux.id, aws_security_group.web.id]
  user_data                   = filebase64("${path.module}/pritunl.sh")
  tags                        = merge({ Name = format("%s-ec2-vpn", var.project_name) }, local.common_tags)
  lifecycle {
   ignore_changes = all
}
}

