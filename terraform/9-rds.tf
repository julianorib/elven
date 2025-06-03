## Password

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&"
}

## Criar uma Instância DB com Engine Mysql
resource "aws_db_instance" "mysqldb" {
  allocated_storage      = 20
  identifier             = format("%s-db", var.project_name)
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.instance_mysql
  username               = "admin"
  password               = random_password.password.result
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.acesso-in-mysql.id]
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.mysqldb.id
  multi_az = true
  tags                   = merge({ Name = format("%s-MySQL", var.project_name) }, local.common_tags)
}

resource "aws_db_subnet_group" "mysqldb" {
  name       = format("%s-db", var.project_name)
  subnet_ids = [aws_subnet.private-1a.id, aws_subnet.private-1b.id]

  tags = merge({ Name = format("%s-MySQL", var.project_name) }, local.common_tags)

}
