## Criar a Instância Modelo
resource "aws_instance" "modelo" {
  ami             = data.aws_ami.amzn-linux-2023-ami.id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.main.key_name
  subnet_id       = aws_subnet.private-1a.id
  security_groups = [aws_security_group.acesso-out-internet.id, aws_security_group.acesso-in-ssh.id, aws_security_group.acesso-in-http.id, aws_security_group.acesso-in-https.id]
  tags = merge({ Name = format("%s-ec2-docker", var.project_name) }, local.common_tags)
  
  user_data = base64encode(templatefile("${path.module}/templates/modelo.tpl", {
    EFS = aws_efs_file_system.wordpress.id
    DBADMINPASS = random_password.admin_password.result
    DBUSERPASS = random_password.wp_password.result
    DBHOST = aws_db_instance.mysqldb.endpoint
  }))
  depends_on = [
    aws_db_instance.mysqldb
  ]
}

resource "aws_ami_from_instance" "amimodelo" {
  name               = format("%s-ec2-ami", var.project_name)
  source_instance_id = aws_instance.modelo.id
  snapshot_without_reboot = true
  tags = merge({ Name = format("%s-ec2-ami", var.project_name) }, local.common_tags)
  depends_on = [
    aws_instance.modelo
  ]
}



# ## Criar a Instância docker
# resource "aws_instance" "docker" {
#   ami             = data.aws_ami.amzn-linux-2023-ami.id
#   instance_type   = var.instance_type
#   key_name        = aws_key_pair.main.key_name
#   subnet_id       = aws_subnet.private-1a.id
#   security_groups = [aws_security_group.acesso-out-internet.id, aws_security_group.acesso-in-ssh.id, aws_security_group.acesso-in-http.id, aws_security_group.acesso-in-https.id]

#   tags = merge({ Name = format("%s-ec2-docker", var.project_name) }, local.common_tags)

#   user_data = filebase64("${path.module}/docker.sh")

# }


# ## Criar a Instância pritunl
# resource "aws_instance" "pritunl" {
#   ami                         = data.aws_ami.amzn-linux-2023-ami.id
#   instance_type               = var.instance_type
#   key_name                    = aws_key_pair.main.key_name
#   subnet_id                   = aws_subnet.public-1a.id
#   associate_public_ip_address = true
#   security_groups             = [aws_security_group.acesso-out-internet.id, aws_security_group.acesso-in-ssh.id, aws_security_group.acesso-in-http.id, aws_security_group.acesso-in-https.id]

#   tags = merge({ Name = format("%s-ec2-vpn", var.project_name) }, local.common_tags)

#   user_data = filebase64("${path.module}/pritunl.sh")

# }

