## Criar um Modelo de Execução para as VMS

resource "aws_launch_template" "main" {
  name_prefix   = format("%s-launch-template", var.project_name)
  image_id      = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = [
    aws_security_group.acesso-out-internet.id,
    aws_security_group.acesso-in-ssh.id,
    aws_security_group.acesso-in-http.id,
    aws_security_group.acesso-in-https.id
  ]
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2-s3-profile.name
  }
  key_name = aws_key_pair.main.key_name
  tag_specifications {
    resource_type = "instance"
    tags          = merge({ Name = format("%s-launch-template", var.project_name) }, local.common_tags)
  }
user_data = base64encode(templatefile("${path.module}/templates/wordpress.tpl", {
#    BUCKET = var.bucket_name,
#    REGION = var.region
  }))

}