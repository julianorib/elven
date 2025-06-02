# ## Criar uma Instância DB com Engine Mysql
resource "aws_db_instance" "mydb" {
  allocated_storage      = 20
  identifier             = "mydb"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t4g.micro"
  username               = "admin"
  password               = "j9aei13Cc51aB"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.acesso-in-mysql.id]
  publicly_accessible    = true

  tags = merge({ Name = format("%s-MySQL", var.project_name) }, local.common_tags)
}

