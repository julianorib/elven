# Criar o volume EFS
resource "aws_efs_file_system" "wordpress" {
  creation_token = "wordpress"
  tags = merge({ Name = format("%s-efs", var.project_name) }, local.common_tags)
}


# Montar o EFS para cada Subrede
resource "aws_efs_mount_target" "subnet-1a" {
  file_system_id = aws_efs_file_system.wordpress.id
  subnet_id      = aws_subnet.private-1a.id
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_mount_target" "subnet-1b" {
  file_system_id = aws_efs_file_system.wordpress.id
  subnet_id      = aws_subnet.private-1b.id
  security_groups = [aws_security_group.efs.id]
}

