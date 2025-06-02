# Criar o volume EFS
resource "aws_efs_file_system" "wordpress" {
  creation_token = "wordpress"

  tags = merge({ Name = format("%s-efs", var.project_name) }, local.common_tags)
}


# Montar o EFS para cada Subrede
resource "aws_efs_mount_target" "alpha" {
  file_system_id = aws_efs_file_system.foo.id
  subnet_id      = aws_subnet.alpha.id
}

#   user_data = <<-EOF
#               #!/bin/bash
#               yum install -y amazon-efs-utils
#               mkdir /mnt/efs
#               mount -t efs ${aws_efs_file_system.shared.id}:/ /mnt/efs
#               EOF