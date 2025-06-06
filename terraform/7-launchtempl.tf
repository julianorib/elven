## Criar um Modelo de Execução para as VMS

resource "aws_launch_template" "main" {
  name   = format("%s-launch-template", var.project_name)
  image_id      = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = var.instance_type
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [
      aws_security_group.asg.id
    ]
  }
  iam_instance_profile {}
  key_name = aws_key_pair.main.key_name
  tag_specifications {
    resource_type = "instance"
    tags          = merge({ Name = format("%s-launch-template", var.project_name) }, local.common_tags)
  }
  user_data = base64encode(templatefile("${path.module}/templates/wp.tpl", {
    EFS    = aws_efs_file_system.main.id
    DBHOST = aws_db_instance.mysqldb.address
    DBUSER = aws_db_instance.mysqldb.username
    DBPASS = aws_db_instance.mysqldb.password
    DB     = var.project_name
  }))
  depends_on = [aws_db_instance.mysqldb]
}
